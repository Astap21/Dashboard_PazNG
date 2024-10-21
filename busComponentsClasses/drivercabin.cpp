#include "drivercabin.h"
#include "canDataBase/canDataBase.h"
#include <QTimer>
#include <QDebug>

DriverCabin::DriverCabin(QObject *parent) : PrimaryBusComponent(parent)
{
    ElecticHeatedWindshield = 0;
    ElecticHeatedSideWindows = 0;
    WasherFluidLamp = 0;
    WipersAutoStatus = 0;
    HeaterMirrorsStatus = 0;
    WipersStatus = 0;
    SeatHeating = 0;

    washerFluidLevel = 0;

    timerPeriod_ms = 500;
    timerForTask.setInterval(timerPeriod_ms);
}

uint DriverCabin::GetWipersWorkCounter(){
    return wipersWorkCounter;
}
void DriverCabin::SetWipersWorkCounter(const uint& inputUint){
    wipersWorkCounter = inputUint;
    emit sendWipersWorkCounter(wipersWorkCounter);
}
float DriverCabin::GetWasherFluidLevel(void){
    return washerFluidLevel;
}
void DriverCabin::ReadStateFromCanDB(){
        previousComponentState = 0;

//        if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_WindshieldHeating, gMessageName_CECU_1, &gCanDB), ElecticHeatedWindshield)) {
//            emit sendWindshieldHeatingStatusToQml(ElecticHeatedWindshield);
//        }
//        if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_SeatHeating, gMessageName_CECU_1, &gCanDB), SeatHeating)) {
//            emit sendSeatHeatingStatusToQml(SeatHeating);
//        }
        uint32_t const rightMirror = gCanDB.GetSignalValueUint32_t(gSignalName_MirrorHeatRight, gMessageName_CDC);
        uint32_t const leftMirror = gCanDB.GetSignalValueUint32_t(gSignalName_MirrorHeatLeft, gMessageName_CDC);
        uint32_t mirrorHeat = 0;
        if (rightMirror == 0 && leftMirror == 0){
            mirrorHeat = 0;
        }
        else {
            mirrorHeat = 1;
        }
        if (checkValueChange(mirrorHeat, HeaterMirrorsStatus)) emit sendHeaterMirrorsStatusToQml(HeaterMirrorsStatus);
        //qDebug() << HeaterMirrorsStatus;

        previousComponentState = WasherFluidLamp;
        washerFluidLevel = gCanDB.GetSignalValueFloat(gSignalName_DD1_WasherFluidLow, gMessageName_DD1_1E);
        float washerFluidLampLevel_percent = 25;
        float washerFluidHysteresisLevel_percent = 5;
        if (washerFluidLevel < washerFluidLampLevel_percent) WasherFluidLamp = 1;
        if (washerFluidLevel > (washerFluidLampLevel_percent + washerFluidHysteresisLevel_percent)) WasherFluidLamp = 0;
        if (previousComponentState != WasherFluidLamp) emit sendWasherFluidLampToQml(WasherFluidLamp);

        if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_FrontNonOperatorWiperSwitch, gMessageName_OWW, &gCanDB), WipersAutoStatus)) emit sendWipersAutoStatusToQml(WipersAutoStatus);
        if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_OperatorSeatDirectionSwitch, gMessageName_CM1, &gCanDB), NoDriver)) emit sendOperatorSeatDirectionSwitchToQml(NoDriver);
        if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_SeatBeltSwitch, gMessageName_BDS, &gCanDB), SeatBelt)) emit sendSeatBeltSwitchToQml(SeatBelt);

    }
void DriverCabin::SendStateToQml(){
    emit sendWasherFluidLevelToQml(washerFluidLevel);
}
void DriverCabin::dashboardLoadFinished(){
    emit sendWindshieldHeatingStatusToQml(ElecticHeatedWindshield);
    emit sendElecticHeatedSideWindowsStatusToQml(ElecticHeatedSideWindows);
    emit sendWasherFluidLampToQml(WasherFluidLamp);
    emit sendWipersStatusToQml(WipersStatus);
    emit sendWipersAutoStatusToQml(WipersAutoStatus);
    emit sendHeaterMirrorsStatusToQml(HeaterMirrorsStatus);
    emit sendOperatorSeatDirectionSwitchToQml(NoDriver);
    emit sendSeatBeltSwitchToQml(SeatBelt);
    emit sendSeatHeatingStatusToQml(SeatHeating);
    emit sendRouteIndicatorToQml(routeIndicator);
    emit sendHeatedSteeringToQml(heatedSteering);
}
