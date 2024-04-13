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
    PowerSteering = 0;
    SeatHeating = 0;

    WasherFluidLevel = 0;

    timerPeriod_ms = 500;
    timerForTask->setInterval(timerPeriod_ms);
}

uint DriverCabin::GetWipersWorkCounter(){
    return wipersWorkCounter;
}
void DriverCabin::SetWipersWorkCounter(const uint& inputUint){
    wipersWorkCounter = inputUint;
    emit sendWipersWorkCounter(wipersWorkCounter);
}

void DriverCabin::ReadStateFromCanDB(){
        previousComponentState = 0;

//        previousComponentState = PowerSteering;;
//        if (gCanDB_ICAN.checkSignalValue_4bit(gCanDB_ICAN.GetSignalValueUint32_t(gSignalName_PowerSteeringError, gMessageName_EVCU_DB1))) PowerSteering = PowerSteeringLamp.LampRed;
//        else if (gCanDB_ICAN.checkSignalValue_4bit(gCanDB_ICAN.GetSignalValueUint32_t(gSignalName_PowerSteeringOff, gMessageName_EVCU_DB1))) PowerSteering = PowerSteeringLamp.LampYellow;
//        else PowerSteering = PowerSteeringLamp.LampOff;
        //qDebug() << PowerSteering;
//        if (previousComponentState != PowerSteering) emit sendPowerSteeringStatusToQml(PowerSteering);

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
        WasherFluidLevel = gCanDB.GetSignalValueFloat(gSignalName_DD1_WasherFluidLow, gMessageName_DD1_1E);
        float washerFluidLampLevel_percent = 50;
        float washerFluidHysteresisLevel_percent = 5;
        if (WasherFluidLevel < washerFluidLampLevel_percent) WasherFluidLamp = 1;
        if (WasherFluidLevel > (washerFluidLampLevel_percent + washerFluidHysteresisLevel_percent)) WasherFluidLamp = 0;
        if (previousComponentState != WasherFluidLamp) emit sendWasherFluidLampToQml(WasherFluidLamp);

        if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_FrontNonOperatorWiperSwitch, gMessageName_OWW, &gCanDB), WipersAutoStatus)) emit sendWipersAutoStatusToQml(WipersAutoStatus);
        if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_OperatorSeatDirectionSwitch, gMessageName_CM1, &gCanDB), NoDriver)) emit sendOperatorSeatDirectionSwitchToQml(NoDriver);
        if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_SeatBeltSwitch, gMessageName_BDS, &gCanDB), SeatBelt)) emit sendSeatBeltSwitchToQml(SeatBelt);

    }
void DriverCabin::SendStateToQml(){
    emit sendWasherFluidLevelToQml(WasherFluidLevel);
}
void DriverCabin::dashboardLoadFinished(){
    emit sendWindshieldHeatingStatusToQml(ElecticHeatedWindshield);
    emit sendElecticHeatedSideWindowsStatusToQml(ElecticHeatedSideWindows);
    emit sendPowerSteeringStatusToQml(PowerSteering);
    emit sendWasherFluidLampToQml(WasherFluidLamp);
    emit sendWipersStatusToQml(WipersStatus);
    emit sendWipersAutoStatusToQml(WipersAutoStatus);
    emit sendHeaterMirrorsStatusToQml(HeaterMirrorsStatus);
    emit sendOperatorSeatDirectionSwitchToQml(NoDriver);
    emit sendSeatBeltSwitchToQml(SeatBelt);
    emit sendSeatHeatingStatusToQml(SeatHeating);
}
