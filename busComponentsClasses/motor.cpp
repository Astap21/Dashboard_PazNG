#include "motor.h"
#include "canDataBase/canDataBase.h"

Motor::Motor(QObject *parent) : PrimaryBusComponent(parent)
{
    actualGear = "P";
    tractionMotorError = 0;
    tractionMotorOverheat = 0;
    lowLiquidLevelMotorSystem = 0;
    vehicleSpeed = 0;
    engineSpeed = 0;
    fuelLevel = 0;
    engineTemp = 0;

    waterInFuel = 0;
    circulationPump = 0;
    airFilterDirty = 0;
    lowOilPressure = 0;
    heatingInsideAir = 0;
    lowUrea = 0;
    exhaustError = 0;
    autoTransOverheating = 0;
    autoTransError = 0;
}
void Motor::ReadStateFromCanDB(){

    vehicleSpeed = gCanDB.GetSignalValueFloat(gSignalName_WheelBasedVehicleSpeed,gMessageName_CCVS1);
    //engineSpeed = gCanDB.GetSignalValueFloat(gSignalName_EngineSpeed,gMessageName_EEC1);
    //engineTemp = gCanDB.GetSignalValueFloat(gSignalName_EngineCoolantTemp,gMessageName_ET1);

    //oilPressure = gCanDB.GetSignalValueInt(gSignalName_EngineOilPressure,gMessageName_EFL);
   // oilTemp = (gCanDB.GetSignalValueInt(gSignalName_EngineOilTemp, gMessageName_ET1));
    //clTemp = (gCanDB.GetSignalValueInt(gSignalName_EngineCoolantTemp, gMessageName_ET1));
    //transmissionOilTemp = gCanDB.GetSignalValueInt(gSignalName_AutoTransmissionOverheat, gMessageName_TRF1);
    //retarderOilTemp = gCanDB.GetSignalValueInt(gSignalName_AutoTransmissionOverheat, gMessageName_TRF1);
    //outputShaftSpeed = gCanDB.GetSignalValueInt(gSignalName_TranOutputShaftSpeed, gMessageName_ETC1);
    fuelLevel = gCanDB.GetSignalValueInt(gSignalName_DD1_ReserveFuelLevel,gMessageName_DD1_12);

    previousComponentStateString = actualGear;
    //Селектор
    if (gCanDB.GetSignalValueInt(gSignalName_TransmissionCurrentGear, gMessageName_ETC2) >= 1.0f) actualGear = "D";
    else if (gCanDB.GetSignalValueInt(gSignalName_TransmissionCurrentGear, gMessageName_ETC2) == 0.0f) actualGear = "N";
    else if (gCanDB.GetSignalValueInt(gSignalName_TransmissionCurrentGear, gMessageName_ETC2) <= -1.0f) actualGear = "R";
    if (actualGear != previousComponentStateString) emit sendActualGearToQml(actualGear);

    previousComponentState = tractionMotorError;
    //if (gCanDB.checkSignalValue_4bit(gCanDB.GetSignalValueUint32_t(gSignalName_EngineError, gMessageName_DM1_EMS))) tractionMotorError = lamp.redLamp;
    //else if (gCanDB.checkSignalValue_4bit(gCanDB.GetSignalValueUint32_t(gSignalName_EngineRedLampFlashing ,gMessageName_DLCC1))) tractionMotorError = lamp.redLampFlashing;
   // else if (gCanDB.checkSignalValue_4bit(gCanDB.GetSignalValueUint32_t(gSignalName_EngineWarning, gMessageName_DM1_EMS))) tractionMotorError = lamp.yellowLamp;
    //else tractionMotorError = lamp.off;
    if (tractionMotorError != previousComponentState) emit sendEngineLampToQml(tractionMotorError);

//    if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_EngineCoolantLevelLowLamp, gMessageName_MUX_to_DB)), lowLiquidLevelMotorSystem)) emit sendEngineLowCoolantLevelToQml(lowLiquidLevelMotorSystem);
    previousComponentState = tractionMotorOverheat;
    if (clTemp > 113.f) tractionMotorOverheat = 1;
    else tractionMotorOverheat = 0;
    if (tractionMotorOverheat != previousComponentState) emit sendOverheatMotorToQml(tractionMotorOverheat);

    //if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_LowLevelCoolingLiquid, gMessageName_DLCD1, &gCanDB), lowLiquidLevelMotorSystem)) emit sendEngineLowCoolantLevelToQml(lowLiquidLevelMotorSystem);
    //if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_WaterInFuel, gMessageName_OI, &gCanDB), waterInFuel)) emit sendWaterInFuelToQml(waterInFuel);
    //if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_AirFilterClogged, gMessageName_DLCC1, &gCanDB), airFilterDirty)) emit sendAirFilterDirtyToQml(airFilterDirty);
    previousComponentState = lowOilPressure;
    const float lowOilTreshold = 60;
    //if ((gCanDB.GetSignalValueFloat(gSignalName_EngineOilPressure, gMessageName_EFL) < lowOilTreshold)) lowOilPressure = 1;
    //else lowOilPressure = 0;
    if (lowOilPressure != previousComponentState) emit sendLowOilPressureToQml(lowOilPressure);

    previousComponentState = lowUrea;
    const float lowUreaTreshold = 10;
    //if ((gCanDB.GetSignalValueFloat(gSignalName_LowUrea, gMessageName_AT1T1I1) < lowUreaTreshold)) lowUrea = 1;
    //else lowUrea = 0;
    if (lowUrea != previousComponentState) emit sendLowUreaToQml(lowUrea);

    //if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_EngineIntakeAirHeating, gMessageName_SHUTDN, &gCanDB), heatingInsideAir)) emit sendHeatingInsideAirToQml(heatingInsideAir);
    //if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_ExhaustSystemError, gMessageName_AT1IG1, &gCanDB), exhaustError)) emit sendExhaustErrorToQml(exhaustError);
    //if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_AutoTrasmissionError, gMessageName_ETC7, &gCanDB), autoTransError)) emit sendAutoTransErrorToQml(autoTransError);

    previousComponentState = autoTransOverheating;
    const float transOverheatTreshold = 115;
    //if ((gCanDB.GetSignalValueFloat(gSignalName_AutoTransmissionOverheat, gMessageName_TRF1) > transOverheatTreshold)) autoTransOverheating = 1;
    //else autoTransOverheating = 0;
    if (autoTransOverheating != previousComponentState) emit sendAutoTransOverheatingToQml(autoTransOverheating);


    previousComponentState = circulationPump;
    if (gCanDB.GetSignalValueUint32_t(gSignalName_AuxHeaterModeReq, gMessageName_CM1) == 5) circulationPump = lamp.redLamp;
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_AuxHeaterModeReq, gMessageName_CM1) == 2) circulationPump = lamp.greenLamp;
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_AuxHeaterModeReq, gMessageName_CM1) == 3) circulationPump = lamp.greenLamp;
    else circulationPump = lamp.off;
    if (circulationPump != previousComponentState) emit sendCirculationPumpToQml(circulationPump);
}

int Motor::getOilPressure()
{
    return oilPressure;
}

int Motor::getOilTemp()
{
    return oilTemp;
}

int Motor::getClTemp()
{
    return clTemp;
}

int Motor::getTransmissionOilTemp()
{
    return transmissionOilTemp;
}

int Motor::getRetarderOilTemp()
{
    return retarderOilTemp;
}

int Motor::getOutputShaftSpeed()
{
    return outputShaftSpeed;
}

int Motor::getFuelLevel()
{
    return fuelLevel;
}

void Motor::SendStateToQml(){
    emit sendSpeedToQml(vehicleSpeed);
    emit sendEngineSpeedToQml(engineSpeed);
    emit sendEngineTempToQml(engineTemp);

    emit sendOilPressureToQml(oilPressure);
    emit sendOilTempToQml(oilTemp);
    emit sendClTempToQml(clTemp);
    emit sendTransmissionOilTempToQml(transmissionOilTemp);
    emit sendRetarderOilTempToQml(retarderOilTemp);
    emit sendOutputShaftSpeedToQml(outputShaftSpeed);
    emit sendFuelLevelToQml(fuelLevel);
}
void Motor::dashboardLoadFinished(){
    emit sendOverheatMotorToQml(tractionMotorOverheat);
    emit sendEngineLampToQml(tractionMotorError);
    emit sendEngineLowCoolantLevelToQml(lowLiquidLevelMotorSystem);
    emit sendWaterInFuelToQml(waterInFuel);
    emit sendCirculationPumpToQml(circulationPump);
    emit sendAirFilterDirtyToQml(airFilterDirty);
    emit sendLowOilPressureToQml(lowOilPressure);
    emit sendHeatingInsideAirToQml(heatingInsideAir);
    emit sendLowUreaToQml(lowUrea);
    emit sendExhaustErrorToQml(exhaustError);
    emit sendAutoTransOverheatingToQml(autoTransOverheating);
    emit sendAutoTransErrorToQml(autoTransError);
}
