#include "motor.h"
#include "canDataBase/canDataBase.h"
#include "canDataBase/canDB_Libs.h"
#include "qdebug.h"

Motor::Motor(QObject *parent) : PrimaryBusComponent(parent)
{
    actualGear = "STOP";
    tractionMotorError = 0;
    tractionMotorOverheat = 0;
    lowLiquidLevelMotorSystem = 0;
    vehicleSpeed = 0;
    batteryStatus = 0;
    engineTemp = 0;
    chargingStatus = 0;
    readyToMove = 0;
}
void Motor::ReadStateFromCanDB(){

    vehicleSpeed = gCanDB.GetSignalValueFloat(gSignalName_WheelBasedVehicleSpeed,gMessageName_CCVS1);
    fuelLevel = gCanDB.GetSignalValueInt(gSignalName_DD1_ReserveFuelLevel,gMessageName_DD1_12);
    hvCurrent = gCanDB.GetSignalValueFloat(gSignalName_HVESS_Current, gMessageName_HVESSD1);
    hvVoltage = gCanDB.GetSignalValueFloat(gSignalName_HVESS_VoltageLevel, gMessageName_HVESSD1);
    hvSoc = gCanDB.GetSignalValueFloat(gSignalName_HVESS_FastUpdateSoc, gMessageName_HVESSD2);
    if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_EstimatedRange, gMessageName_CECU_A0, &gCanDB), estimatedRange)) emit sendEstimatedRangeToQml(estimatedRange);

    previousComponentState = batteryStatus;
    if ((getNewValueFromOneCanSignalU32(gSignalName_Optional1LC, gMessageName_DLCC2, &gCanDB) == canBus::canSignalStateStructObj.on)){
        batteryStatus = 1;
    }
    else if ((getNewValueFromOneCanSignalU32(gSignalName_Optional1LC, gMessageName_DLCC2, &gCanDB) == canBus::canSignalStateStructObj.error)){
        batteryStatus = 2;
    }
    else if ((getNewValueFromOneCanSignalU32(gSignalName_Optional2LC, gMessageName_DLCC2, &gCanDB) == canBus::canSignalStateStructObj.on)){
        batteryStatus = 3;
    }
    else if ((getNewValueFromOneCanSignalU32(gSignalName_Optional2LC, gMessageName_DLCC2, &gCanDB) == canBus::canSignalStateStructObj.error)){
        batteryStatus = 4;
    }
    else if ((getNewValueFromOneCanSignalU32(gSignalName_HVESS_HvBusConnectionStatus, gMessageName_HVESSS1, &gCanDB) == 1)){
        batteryStatus = 5;
    }
    else if ((getNewValueFromOneCanSignalU32(gSignalName_HVESS_HvBusConnectionStatus, gMessageName_HVESSS1, &gCanDB) == 2)){
        batteryStatus = 6;
    }
    else{
        batteryStatus = 0;
    }
    if (batteryStatus != previousComponentState) emit sendBatteryStatusToQml(batteryStatus);
    //sqDebug() << estimatedRange;
    engineTemp = gCanDB.GetSignalValueFloat(gSignalName_Temp_CL,gMessageName_ET1);
    const float highTemp = 65;
    if (engineTemp >= highTemp && tractionMotorOverheat != 1){
        tractionMotorOverheat = 1;
        emit sendOverheatMotorToQml(tractionMotorOverheat);
    }
    else{
        if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_EngineCoolantTempHighLC, gMessageName_DLCC1, &gCanDB), tractionMotorOverheat)) emit sendOverheatMotorToQml(tractionMotorOverheat);
    }

    //oilPressure = gCanDB.GetSignalValueInt(gSignalName_EngineOilPressure,gMessageName_EFL);
   // oilTemp = (gCanDB.GetSignalValueInt(gSignalName_EngineOilTemp, gMessageName_ET1));
    //clTemp = (gCanDB.GetSignalValueInt(gSignalName_EngineCoolantTemp, gMessageName_ET1));
    //transmissionOilTemp = gCanDB.GetSignalValueInt(gSignalName_AutoTransmissionOverheat, gMessageName_TRF1);
    //retarderOilTemp = gCanDB.GetSignalValueInt(gSignalName_AutoTransmissionOverheat, gMessageName_TRF1);
    //outputShaftSpeed = gCanDB.GetSignalValueInt(gSignalName_TranOutputShaftSpeed, gMessageName_ETC1);

    previousComponentStateString = actualGear;
    //Селектор
    uint8_t gear = gCanDB.GetSignalValueUint32_t(gSignalName_TransmissionCurrentGear, gMessageName_ETC2);
    if (movementBanByDoor || movementBanByBrakeSystem){
        actualGear = "STOP";
    }
    else if (gear == 0x7D) actualGear = "N";
    else if (gear == 0xDF) actualGear = "R";
    else if (gear == 0xE0) actualGear = "P";
    else if (gear == 0xFB) actualGear = "P";
    else if (gear == 0xFC) actualGear = "D";
    else{
        qDebug() << "Actual gear error -" << gear;
        actualGear = "STOP";
    }
    if (actualGear != previousComponentStateString) emit sendActualGearToQml(actualGear);

    previousComponentState = tractionMotorError;
    if (gCanDB.GetSignalValueUint32_t(gSignalName_EngineRedStopLC, gMessageName_DLCC1) == canBus::canSignalStateStructObj.on) tractionMotorError = 1;
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_EngineRedStopLC, gMessageName_DLCC1) == canBus::canSignalStateStructObj.error) tractionMotorError = 2;
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_EngineAmberWarningLC, gMessageName_DLCC1) == canBus::canSignalStateStructObj.on) tractionMotorError = 3;
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_EngineAmberWarningLC, gMessageName_DLCC1) == canBus::canSignalStateStructObj.error) tractionMotorError = 4;
    else tractionMotorError = lamp.off;
    if (tractionMotorError != previousComponentState) emit sendEngineLampToQml(tractionMotorError);

    //if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_EngineIntakeAirHeating, gMessageName_SHUTDN, &gCanDB), heatingInsideAir)) emit sendHeatingInsideAirToQml(heatingInsideAir);
    //if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_ExhaustSystemError, gMessageName_AT1IG1, &gCanDB), exhaustError)) emit sendExhaustErrorToQml(exhaustError);
    //if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_AutoTrasmissionError, gMessageName_ETC7, &gCanDB), autoTransError)) emit sendAutoTransErrorToQml(autoTransError);

    previousComponentState = circulationPump;
    if (gCanDB.GetSignalValueUint32_t(gSignalName_AuxHeaterModeReq, gMessageName_CM1) == 5) circulationPump = lamp.redLamp;
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_AuxHeaterModeReq, gMessageName_CM1) == 2) circulationPump = lamp.greenLamp;
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_AuxHeaterModeReq, gMessageName_CM1) == 3) circulationPump = lamp.greenLamp;
    else circulationPump = lamp.off;
    if (circulationPump != previousComponentState) emit sendCirculationPumpToQml(circulationPump);

    previousComponentState = steeringWheel;
    if (gCanDB.GetSignalValueUint32_t(gSignalName_WheelSteerActuatorState, gMessageName_ESC2) == 2) steeringWheel = lamp.redLamp;
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_WheelSteerActuatorState, gMessageName_ESC2) == 0) steeringWheel = lamp.yellowLamp;
    else steeringWheel = lamp.off;
    if (steeringWheel != previousComponentState) emit send_steeringWheelToQml(steeringWheel);

    previousComponentState = isolation;
    if (gCanDB.GetSignalValueUint32_t(gSignalName_Optional4LC, gMessageName_DLCC2) == canBus::canSignalStateStructObj.on) isolation = 5;
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_Optional4LC, gMessageName_DLCC2) == canBus::canSignalStateStructObj.error) isolation = 4;
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_Optional3LC, gMessageName_DLCC2) == canBus::canSignalStateStructObj.on) isolation = 3;
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_Optional3LC, gMessageName_DLCC2) == canBus::canSignalStateStructObj.error) isolation = 2;
    else isolation = 0;
    if (isolation != previousComponentState) emit send_isolationToQml(isolation);

    previousComponentState = pant;
    uint newPantState = gCanDB.GetSignalValueUint32_t(gSignalName_PantographModuleState, gMessageName_PCM1);
    if (newPantState == 1) {
        pant = 1;
    }
    else if (newPantState == 2 || (newPantState == 3) || (newPantState == 4) || (newPantState == 5)) {
        pant = 2;
    }
    else if (newPantState == 8 || (newPantState == 9) || (newPantState == 10) || (newPantState == 11) || (newPantState == 12) || (newPantState == 14)) {
        pant = 3;
    }
    else {
        pant = 0;
    }
    if (pant != previousComponentState) {
        emit send_pantToQml(pant);
    }

    previousComponentState = batteryHeating;
    if (gCanDB.GetSignalValueUint32_t(gSignalName_TmsMode, gMessageName_TMS) == 2) batteryHeating = 1;
    else batteryHeating = 0;
    if (batteryHeating != previousComponentState) emit send_batteryHeatingToQml(batteryHeating);

    previousComponentState = tmsError;
    if (gCanDB.GetSignalValueUint32_t(gSignalName_TmsError, gMessageName_TMS) != 0) tmsError = 1;
    else tmsError = 0;
    if (tmsError != previousComponentState) emit send_tmsErrorToQml(tmsError);


    if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_TmsMode, gMessageName_TMS, &gCanDB), tmsOn)) emit send_tmsOnToQml(tmsOn);
    if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_BatteryCharger1State, gMessageName_BCH1, &gCanDB), chargingStatus)) emit send_externalCordToQml(chargingStatus);
    if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_EngineCoolantLevelLowLC, gMessageName_DLCC1, &gCanDB), lowLiquidLevelMotorSystem)) emit sendEngineLowCoolantLevelToQml(lowLiquidLevelMotorSystem);
    if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_ReadyForUseLC, gMessageName_DLCC1, &gCanDB), readyToMove)) emit sendReadyToMoveToQml(readyToMove);
    if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_VehicleLimitedPerformanceModeLC, gMessageName_DLCC2, &gCanDB), lowPower)) emit sendLowPowerToQml(lowPower);

    previousComponentState = contactor;
    if (getNewValueFromOneCanSignalU32(gSignalName_HVESS_HvPositiveContactorState, gMessageName_HVESSS1, &gCanDB) == 2 ||
        getNewValueFromOneCanSignalU32(gSignalName_HVESS_HvNegativeContactorState, gMessageName_HVESSS1, &gCanDB) == 2 ||
        getNewValueFromOneCanSignalU32(gSignalName_HVESS_HvBusPrechargeRelay, gMessageName_HVESSS1, &gCanDB) == 2 ||
        getNewValueFromOneCanSignalU32(gSignalName_HVESS_CenterOfPackContactor, gMessageName_HVESSS1, &gCanDB) == 2)
    {
        contactor = 2;
    }
    if (contactor != previousComponentState) emit send_contactorToQml(contactor);
}

void Motor::SendStateToQml(){
    emit sendSpeedToQml(vehicleSpeed);
    emit sendHvCurrentToQml(hvCurrent);
    emit sendHvVoltageToQml(hvVoltage);
    emit sendHvSocToQml(hvSoc);
    emit sendEngineTempToQml(engineTemp);
    //emit sendFuelLevelToQml(fuelLevel);
}
void Motor::dashboardLoadFinished(){
    emit sendServiceToQml(service);
    emit sendActualGearToQml(actualGear);

    emit sendLowPowerToQml(lowPower);
    emit sendReadyToMoveToQml(readyToMove);
    emit sendOverheatMotorToQml(tractionMotorOverheat);
    emit sendEngineLampToQml(tractionMotorError);
    emit sendEngineLowCoolantLevelToQml(lowLiquidLevelMotorSystem);
    emit sendCirculationPumpToQml(circulationPump);
    emit sendEstimatedRangeToQml(estimatedRange);
    emit sendBatteryStatusToQml(batteryStatus);

    emit send_batteryHeatingToQml(batteryHeating);
    emit send_motorStatusToQml(motorStatus);
    emit send_tmsErrorToQml(tmsError);
    emit send_externalCordToQml(chargingStatus);
    emit send_steeringWheelToQml(steeringWheel);
    emit send_isolationToQml(isolation);
    emit send_pantToQml(pant);
    emit send_contactorToQml(contactor);
}
void Motor::NeedMovementBanByDoor(const uint& inputUint){
    movementBanByDoor = inputUint;
}
void Motor::NeedMovementBanByBrakeSystem(const uint& inputUint){
    movementBanByBrakeSystem = inputUint;
}
