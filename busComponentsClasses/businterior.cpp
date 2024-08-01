#include "businterior.h"
#include "canDataBase/canDataBase.h"
#include <QTimer>
#include <QDebug>

BusInterior::BusInterior(QObject *parent) : PrimaryBusComponent(parent)
{
    interiorLightning = 0;
    hammerLamp = 0;
    fireExtingusherLamp = 0;
    liquidHeater = 0;
    fuelLevelLamp = 0;
    rampStatus = 0;
    requestDisablePerson = 0;
    rearCompartment = 0;
    frontCompartment = 0;
    FuelLevel = 0;
    BatteryVoltage24v = 0;
    rampError = 0;
    doorValve = 0;
    insideTempS = "";
    outsideTempS = "";

    timerPeriod_ms = 500;
    timerForTask.setInterval(timerPeriod_ms);
}
void BusInterior::ReadStateFromCanDB(){
        previousComponentState = 0;

        if (checkValueChange(uint(getNewValueFromOneCanSignalF(gSignalName_SalonLightning, gMessageName_CL, &gCanDB)), interiorLightning)) emit sendInteriorLightingToQml(interiorLightning);
//        if (checkValueChange(uint(getNewValueFromOneCanSignalF(gSignalName_LiquidHeater, gMessageName_CM1)), liquidHeater)) emit sendLiquidHeaterToQml(liquidHeater);
//        if (checkValueChange(uint(getNewValueFromOneCanSignalF(gSignalName_LowFuelLevel, gMessageName_DLCD2)), fuelLevelLamp)) emit sendFuelLevelLampToQml(fuelLevelLamp);
        if (checkValueChange(uint(getNewValueFromOneCanSignalU32(gSignalName_RampError, gMessageName_DC1, &gCanDB)), rampError)) emit sendRampErrorToQml(rampError);
        if (checkValueChange(uint(getNewValueFromOneCanSignalU32(gSignalName_EngineHatchOpen, gMessageName_DC2, &gCanDB)), rearCompartment)) emit sendRearCompartmentStatusToQml(rearCompartment);
//        if (checkValueChange(uint(getNewValueFromOneCanSignalF(gSignalName_FrontCompartmentStatus, gMessageName_MUX_to_DB, &gCanDB)), frontCompartment)) emit sendFrontCompartmentStatusToQml(frontCompartment);
        previousComponentState = requestDisablePerson;
        if (gCanDB.GetSignalValueUint32_t(gSignalName_RequestOpenRamp1, gMessageName_EDSC2_2) == 1) requestDisablePerson = 1;
        else if (gCanDB.GetSignalValueUint32_t(gSignalName_RequestOpenRamp2, gMessageName_EDSC2_2) == 1) requestDisablePerson = 1;
        else requestDisablePerson = 0;
        if (previousComponentState != requestDisablePerson) emit sendRequestDisablePersonToQml(requestDisablePerson);


        previousComponentState = rampStatus;
        if (gCanDB.GetSignalValueUint32_t(gSignalName_RampError, gMessageName_DC1) == 1) rampStatus = 1;
        else if (gCanDB.GetSignalValueUint32_t(gSignalName_RampError, gMessageName_DC1) == 2) rampStatus = 2;
        else rampStatus = 0;
        if (previousComponentState != rampStatus) emit sendRampStatusToQml(rampStatus);

        previousComponentState = hammerLamp;
        if (gCanDB.GetSignalValueUint32_t(gSignalName_EmergHammer_1, gMessageName_FS1) == 1) hammerLamp = 1;
        else if (gCanDB.GetSignalValueUint32_t(gSignalName_EmergHammer_2, gMessageName_FS1) == 1) hammerLamp = 1;
        else if (gCanDB.GetSignalValueUint32_t(gSignalName_EmergHammer_3, gMessageName_FS1) == 1) hammerLamp = 1;
        else if (gCanDB.GetSignalValueUint32_t(gSignalName_EmergHammer_4, gMessageName_FS1) == 1) hammerLamp = 1;
        else hammerLamp = 0;
        if (previousComponentState != hammerLamp) emit sendHammerStatusToQml(hammerLamp);

        previousComponentState = fireExtingusherLamp;
        if (gCanDB.GetSignalValueUint32_t(gSignalName_FireExting_1, gMessageName_FS1) == 1) fireExtingusherLamp = 1;
        else if (gCanDB.GetSignalValueUint32_t(gSignalName_FireExting_2, gMessageName_FS1) == 1) fireExtingusherLamp = 1;
        else if (gCanDB.GetSignalValueUint32_t(gSignalName_FireExting_3, gMessageName_FS1) == 1) fireExtingusherLamp = 1;
        else if (gCanDB.GetSignalValueUint32_t(gSignalName_FireExting_4, gMessageName_FS1) == 1) fireExtingusherLamp = 1;
        else fireExtingusherLamp = 0;
        if (previousComponentState != fireExtingusherLamp) emit sendFireExtingStatusToQml(fireExtingusherLamp);
        previousComponentState = doorValve;
//        if (gCanDB.GetSignalValueUint32_t(gSignalName_Door1EmergencyOpening1, gMessageName_DCU1) == 1) doorValve = 2;
//        else if (gCanDB.GetSignalValueUint32_t(gSignalName_Door2EmergencyOpening1, gMessageName_DCU2) == 1) doorValve = 2;
//        else if (gCanDB.GetSignalValueUint32_t(gSignalName_Door3EmergencyOpening1, gMessageName_DCU3) == 1) doorValve = 2;
//        else if (gCanDB.GetSignalValueUint32_t(gSignalName_Door1Pinching, gMessageName_DCU1) == 1) doorValve = 1;
//        else if (gCanDB.GetSignalValueUint32_t(gSignalName_Door2Pinching, gMessageName_DCU2) == 1) doorValve = 1;
//        else if (gCanDB.GetSignalValueUint32_t(gSignalName_Door3Pinching, gMessageName_DCU3) == 1) doorValve = 1;
//        else doorValve = 0;
        if (previousComponentState != doorValve) {
            emit sendDoorValveToQml(doorValve);
        }
        if (checkValueChangeBy_01(gCanDB.GetSignalValueFloat(gSignalName_ActualVoltage_24v, gMessageName_VEP1), BatteryVoltage24v)){
            emit sendBattery24VoltageToQml(BatteryVoltage24v);
        }
        if (checkValueChangeBy_1(gCanDB.GetSignalValueFloat(gSignalName_AmbientAirTemp, gMessageName_AMB), outsideTempF)){
            outsideTempS = convertFloatToStrForTemp(outsideTempF);
            emit sendTempOutsideToQml(outsideTempS);
        }
        if (checkValueChangeBy_1(gCanDB.GetSignalValueFloat(gSignalName_CabInteriorTempA, gMessageName_AMB), insideTempF)){
            insideTempS = convertFloatToStrForTemp(insideTempF);
            emit sendTempInsideToQml(insideTempS);
        }
        if (checkValueChangeBy_1(gCanDB.GetSignalValueFloat(gSignalName_CabInteriorTempB, gMessageName_AMB), salonTempF)){
            salonTempS = convertFloatToStrForTemp(salonTempF);
            emit sendTempSalonToQml(salonTempS);
        }
    }
void BusInterior::SendStateToQml(){

}
void BusInterior::dashboardLoadFinished(){
    emit sendInteriorLightingToQml(interiorLightning);
    emit sendLiquidHeaterToQml(liquidHeater);
    emit sendFuelLevelLampToQml(fuelLevelLamp);
    emit sendRampStatusToQml(rampStatus);
    emit sendRequestDisablePersonToQml(requestDisablePerson);
    emit sendRearCompartmentStatusToQml(rearCompartment);
    emit sendFrontCompartmentStatusToQml(frontCompartment);
    emit sendHammerStatusToQml(hammerLamp);
    emit sendFireExtingStatusToQml(fireExtingusherLamp);
    emit sendRampErrorToQml(rampError);
    emit sendDoorValveToQml(doorValve);
}

QString BusInterior::convertFloatToStrForTemp(double inputNumber){
    QString returnedSting;
    if (inputNumber > 0) returnedSting = "+" + QString::number(round(inputNumber));
    else returnedSting = QString::number(round(inputNumber));
    if (inputNumber < -99) returnedSting = "-99";
    if (inputNumber > 99) returnedSting = "99";
    if (returnedSting.length() > 3) returnedSting.resize(3);
    //qDebug() << inputNumber;
    return returnedSting;
}
