#include "doorsPaz.h"
#include <QDebug>
#include "canDataBase/canDataBase.h"

DoorsPaz::DoorsPaz(QObject *parent) : Doors(parent)
{
    maxDoors = 2;
}

valve_state_e DoorsPaz::GetValveStatus(const int &_doorNumber, const valve_side_e &side){
    const canBus::messageNameCharStruct *canMsg;
    const canBus::signalNameCharStruct *cap;
    const canBus::signalNameCharStruct *valve;
    if (_doorNumber == 1 && side == valve_side_e::in) {
        canMsg = &gMessageName_DOZC_1;
        valve =  &gSignalName_Door1ValveInside;
        cap =  &gSignalName_Door1CapInside;
    }
    else if (_doorNumber == 2 && side == valve_side_e::in) {
        canMsg = &gMessageName_DOZC_2;
        valve =  &gSignalName_Door2ValveInside;
        cap =  &gSignalName_Door2CapInside;
    }
    if (_doorNumber == 1 && side == valve_side_e::out) {
        canMsg = &gMessageName_DOZC_1;
        valve =  &gSignalName_Door1ValveOutside;
        cap =  &gSignalName_Door1CapOutside;
    }
    else if (_doorNumber == 2 && side == valve_side_e::out) {
        canMsg = &gMessageName_DOZC_2;
        valve =  &gSignalName_Door2ValveOutside;
        cap =  &gSignalName_Door2CapOutside;
    }
    else{
        return valve_state_e::openValve;
    }

    valve_state_e valve_state = valve_state_e::openValve;
    if ((gCanDB.GetSignalValueUint32_t(*valve, *canMsg)) == 1) {
        valve_state = valve_state_e::openValve;
    }
    else if ((gCanDB.GetSignalValueUint32_t(*cap, *canMsg)) == 1) {
        valve_state = valve_state_e::closeValveOpenCap;
    }
    else{
        valve_state = valve_state_e::closeValveCloseCap;
    }
    return valve_state;
}

uint DoorsPaz::GetRampState(){
    uint rampStatus;
    if (gCanDB.GetSignalValueUint32_t(gSignalName_Door1RampOpen, gMessageName_DOZC_1) == 1) {
        rampStatus = 1;
    }
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_RampError, gMessageName_DC1) == 2) {
        rampStatus = 2;
    }
    else {
        rampStatus = 0;
    }
    return rampStatus;
}

uint DoorsPaz::returnDoorStatus(const int &_doorNumber){
    const canBus::messageNameCharStruct *canMsg;
    const canBus::signalNameCharStruct *AntiPinch1;
    const canBus::signalNameCharStruct *AntiPinch2;
    const canBus::signalNameCharStruct *AntiPinch3;
    const canBus::signalNameCharStruct *RqOpenInside;
    const canBus::signalNameCharStruct *RqOpenOutside;
    const canBus::signalNameCharStruct *Open;
    const canBus::signalNameCharStruct *Closing;
    const canBus::signalNameCharStruct *Opening;
    const canBus::signalNameCharStruct *Close;
    const canBus::signalNameCharStruct *EmgOpen;
    if (_doorNumber == 1) {
        canMsg = &gMessageName_DOZC_1;
        AntiPinch1 =  &gSignalName_Door1Pinching1;
        AntiPinch2 =  &gSignalName_Door1Pinching2;
        AntiPinch3 =  &gSignalName_Door1Pinching3;
        RqOpenInside =  &gSignalName_Door1RqOpenInside;
        RqOpenOutside =  &gSignalName_Door1RqOpenOutside;
        Open = &gSignalName_Door1Open;
        Closing = &gSignalName_Door1Closing;
        Opening = &gSignalName_Door1Opening;
        Close = &gSignalName_Door1Close;
        EmgOpen = &gSignalName_Door1EmgOpening;
    }
    else if (_doorNumber == 2) {
        canMsg = &gMessageName_DOZC_2;
        AntiPinch1 =  &gSignalName_Door2Pinching1;
        AntiPinch2 =  &gSignalName_Door2Pinching2;
        AntiPinch3 =  &gSignalName_Door2Pinching3;
        RqOpenInside =  &gSignalName_Door2RqOpenInside;
        RqOpenOutside =  &gSignalName_Door2RqOpenOutside;
        Open = &gSignalName_Door2Open;
        Closing = &gSignalName_Door2Closing;
        Opening = &gSignalName_Door2Opening;
        Close = &gSignalName_Door2Close;
        EmgOpen = &gSignalName_Door2EmgOpening;
    }
    else{
        return 0;
    }
    enum class door_e{
        close = 0,
        reqOpen = 1,
        open = 2,
        EmgOpen = 3,
        Jamming = 4,
        doorNotDefined = 5,
    };

    door_e doorStatus = door_e::close;
    if ((gCanDB.GetSignalValueUint32_t(*Close, *canMsg)) == 1) doorStatus = door_e::close;
    else if ((gCanDB.GetSignalValueUint32_t(*Opening, *canMsg)) == 1) doorStatus = door_e::close;
    else if ((gCanDB.GetSignalValueUint32_t(*Closing, *canMsg)) == 1) doorStatus = door_e::close;
    else if ((gCanDB.GetSignalValueUint32_t(*Open, *canMsg)) == 1) doorStatus = door_e::open;
    else{
        doorStatus = door_e::doorNotDefined;
    }
    if (doorStatus == door_e::close){
        if ((gCanDB.GetSignalValueUint32_t(*RqOpenInside, *canMsg)) == 1) doorStatus = door_e::reqOpen;
        if ((gCanDB.GetSignalValueUint32_t(*RqOpenOutside, *canMsg)) == 1) doorStatus = door_e::reqOpen;
    }
    if ((gCanDB.GetSignalValueUint32_t(*AntiPinch1, *canMsg)) == 1) doorStatus = door_e::Jamming;
    if ((gCanDB.GetSignalValueUint32_t(*AntiPinch2, *canMsg)) == 1) doorStatus = door_e::Jamming;
    if ((gCanDB.GetSignalValueUint32_t(*AntiPinch3, *canMsg)) == 1) doorStatus = door_e::Jamming;
    if ((gCanDB.GetSignalValueUint32_t(*EmgOpen, *canMsg)) == 1) doorStatus = door_e::EmgOpen;

    return static_cast<uint>(doorStatus);
}
