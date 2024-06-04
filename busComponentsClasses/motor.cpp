#include "motor.h"
#include "canDataBase/canDataBase.h"
#include "qdebug.h"

Motor::Motor(QObject *parent) : PrimaryBusComponent(parent)
{
    actualGear = "P";
    tractionMotorError = 0;
    tractionMotorOverheat = 0;
    lowLiquidLevelMotorSystem = 0;
    vehicleSpeed = 0;
    batteryStatus = 0;
    engineTemp = 0;
}
void Motor::ReadStateFromCanDB(){

    vehicleSpeed = gCanDB.GetSignalValueFloat(gSignalName_WheelBasedVehicleSpeed,gMessageName_CCVS1);
    hvCurrent = gCanDB.GetSignalValueFloat(gSignalName_HvCurrent, gMessageName_ELECTRO_1);
    hvVoltage = gCanDB.GetSignalValueFloat(gSignalName_HvVoltage, gMessageName_ELECTRO_1);
    hvSoc = gCanDB.GetSignalValueFloat(gSignalName_HvSoc, gMessageName_ELECTRO_1);
    if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_EstimatedRange, gMessageName_CECU_A0, &gCanDB), estimatedRange)) emit sendEstimatedRangeToQml(estimatedRange);

    previousComponentState = batteryStatus;
    if ((getNewValueFromOneCanSignalU32(gSignalName_BatteryError, gMessageName_Motor_1, &gCanDB) == 1)){
        batteryStatus = 2;
    }
    else if ((getNewValueFromOneCanSignalU32(gSignalName_HvBatteryOn, gMessageName_ELECTRO_1, &gCanDB) == 1)){
        batteryStatus = 1;
    }
    else{
        batteryStatus = 0;
    }
    if (batteryStatus != previousComponentState) emit sendBatteryStatusToQml(batteryStatus);
    //sqDebug() << estimatedRange;
    //engineTemp = gCanDB.GetSignalValueFloat(gSignalName_EngineCoolantTemp,gMessageName_ET1);

    //oilPressure = gCanDB.GetSignalValueInt(gSignalName_EngineOilPressure,gMessageName_EFL);
   // oilTemp = (gCanDB.GetSignalValueInt(gSignalName_EngineOilTemp, gMessageName_ET1));
    //clTemp = (gCanDB.GetSignalValueInt(gSignalName_EngineCoolantTemp, gMessageName_ET1));
    //transmissionOilTemp = gCanDB.GetSignalValueInt(gSignalName_AutoTransmissionOverheat, gMessageName_TRF1);
    //retarderOilTemp = gCanDB.GetSignalValueInt(gSignalName_AutoTransmissionOverheat, gMessageName_TRF1);
    //outputShaftSpeed = gCanDB.GetSignalValueInt(gSignalName_TranOutputShaftSpeed, gMessageName_ETC1);

    previousComponentStateString = actualGear;
    //Селектор
    if (gCanDB.GetSignalValueInt(gSignalName_TransmissionCurrentGear, gMessageName_ETC2) >= 1.0f) actualGear = "D";
    else if (gCanDB.GetSignalValueInt(gSignalName_TransmissionCurrentGear, gMessageName_ETC2) == 0.0f) actualGear = "N";
    else if (gCanDB.GetSignalValueInt(gSignalName_TransmissionCurrentGear, gMessageName_ETC2) <= -1.0f) actualGear = "R";
    if (actualGear != previousComponentStateString) emit sendActualGearToQml(actualGear);

    previousComponentState = tractionMotorError;
    if (gCanDB.checkSignalValue_4bit(gCanDB.GetSignalValueUint32_t(gSignalName_MotorError, gMessageName_Motor_1))) tractionMotorError = lamp.redLamp;
    else if (gCanDB.checkSignalValue_4bit(gCanDB.GetSignalValueUint32_t(gSignalName_MotorWarning, gMessageName_Motor_1))) tractionMotorError = lamp.yellowLamp;
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
}

void Motor::SendStateToQml(){
    emit sendSpeedToQml(vehicleSpeed);
    emit sendHvCurrentToQml(hvCurrent);
    emit sendHvVoltageToQml(hvVoltage);
    emit sendHvSocToQml(hvSoc);
    emit sendEngineTempToQml(engineTemp);

}
void Motor::dashboardLoadFinished(){
    emit sendOverheatMotorToQml(tractionMotorOverheat);
    emit sendEngineLampToQml(tractionMotorError);
    emit sendEngineLowCoolantLevelToQml(lowLiquidLevelMotorSystem);
    emit sendCirculationPumpToQml(circulationPump);
    emit sendEstimatedRangeToQml(estimatedRange);
    emit sendBatteryStatusToQml(batteryStatus);
}
