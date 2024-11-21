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

        if (checkValueChange(uint(getNewValueFromOneCanSignalF(gSignalName_SalonLightning, gMessageName_CL, &gCanDB)), interiorLightning)) {
            const float roundStep = 25.0;
            interiorLightning = qRound(interiorLightning / roundStep) * roundStep;
            emit sendInteriorLightingToQml(interiorLightning);
        }
//        if (checkValueChange(uint(getNewValueFromOneCanSignalF(gSignalName_LiquidHeater, gMessageName_CM1)), liquidHeater)) emit sendLiquidHeaterToQml(liquidHeater);
//        if (checkValueChange(uint(getNewValueFromOneCanSignalF(gSignalName_LowFuelLevel, gMessageName_DLCD2)), fuelLevelLamp)) emit sendFuelLevelLampToQml(fuelLevelLamp);
        if (checkValueChange(uint(getNewValueFromOneCanSignalU32(gSignalName_RampError, gMessageName_DC1, &gCanDB)), rampError)) emit sendRampErrorToQml(rampError);
        if (checkValueChange(uint(getNewValueFromOneCanSignalU32(gSignalName_EngineHatchOpen, gMessageName_DC2, &gCanDB)), rearCompartment)) emit sendRearCompartmentStatusToQml(rearCompartment);
//        if (checkValueChange(uint(getNewValueFromOneCanSignalF(gSignalName_FrontCompartmentStatus, gMessageName_MUX_to_DB, &gCanDB)), frontCompartment)) emit sendFrontCompartmentStatusToQml(frontCompartment);
        previousComponentState = requestDisablePerson;
        if (gCanDB.GetSignalValueUint32_t(gSignalName_Door1RqOpenInside, gMessageName_DOZC_1) == 1 ||
                gCanDB.GetSignalValueUint32_t(gSignalName_Door1RqOpenOutside, gMessageName_DOZC_1) == 1) {
            requestDisablePerson = 1;
        }
        else if (gCanDB.GetSignalValueUint32_t(gSignalName_Door2RqOpenInside, gMessageName_DOZC_2) == 1 ||
                 gCanDB.GetSignalValueUint32_t(gSignalName_Door2RqOpenOutside, gMessageName_DOZC_2) == 1) {
            requestDisablePerson = 1;
        }
        else {
            requestDisablePerson = 0;
        }
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
//        previousComponentState = doorValve;
//        if (gCanDB.GetSignalValueUint32_t(gSignalName_Door1EmergencyOpening1, gMessageName_DCU1) == 1) doorValve = 2;
//        else if (gCanDB.GetSignalValueUint32_t(gSignalName_Door2EmergencyOpening1, gMessageName_DCU2) == 1) doorValve = 2;
//        else if (gCanDB.GetSignalValueUint32_t(gSignalName_Door3EmergencyOpening1, gMessageName_DCU3) == 1) doorValve = 2;
//        else if (gCanDB.GetSignalValueUint32_t(gSignalName_Door1Pinching, gMessageName_DCU1) == 1) doorValve = 1;
//        else if (gCanDB.GetSignalValueUint32_t(gSignalName_Door2Pinching, gMessageName_DCU2) == 1) doorValve = 1;
//        else if (gCanDB.GetSignalValueUint32_t(gSignalName_Door3Pinching, gMessageName_DCU3) == 1) doorValve = 1;
//        else doorValve = 0;
//        if (previousComponentState != doorValve) {
//            emit sendDoorValveToQml(doorValve);
//        }
        if (checkValueChangeBy_01(gCanDB.GetSignalValueFloat(gSignalName_ActualVoltage_24v, gMessageName_VEP1), BatteryVoltage24v)){
            emit sendBattery24VoltageToQml(BatteryVoltage24v);
        }
        if (checkValueChange(uint(getNewValueFromOneCanSignalF(gSignalName_VehicleBatteryChargingLC, gMessageName_DLCC2, &gCanDB)), error24v)) {
            emit sendError24VToQml(error24v);
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
        float salonTemp1 = gCanDB.GetSignalValueFloat(gSignalName_SalonTemp_1, gMessageName_CCUT1);
        float salonTemp2 = gCanDB.GetSignalValueFloat(gSignalName_SalonTemp_2, gMessageName_CCUT1);
        float salonTemp3 = gCanDB.GetSignalValueFloat(gSignalName_SalonTemp_3, gMessageName_CCUT1);
        float salonTemp4 = gCanDB.GetSignalValueFloat(gSignalName_RoofTemp, gMessageName_CCUT1);

        if (checkValueChangeBy_1((salonTemp1 + salonTemp2 + salonTemp3 + salonTemp4) / 4, salonTempF)){
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
    emit sendTempSalonToQml(convertFloatToStrForTemp(salonTempF));
    emit sendTempOutsideToQml(convertFloatToStrForTemp(outsideTempF));
    emit sendTempInsideToQml(convertFloatToStrForTemp(insideTempF));
    emit sendBattery24VoltageToQml(BatteryVoltage24v);
}

QString BusInterior::convertFloatToStrForTemp(double inputNumber){
    QString returnedSting;
//    if (inputNumber > 0) returnedSting = "+" + QString::number(round(inputNumber));
//    else returnedSting = QString::number(round(inputNumber));
    returnedSting = QString::number(round(inputNumber));
    if (inputNumber < -39) returnedSting = "--";
    if (inputNumber > 200) returnedSting = "--";
    if (returnedSting.length() > 3) returnedSting.resize(3);
    //qDebug() << inputNumber;
    returnedSting += "°";
    return returnedSting;
}
