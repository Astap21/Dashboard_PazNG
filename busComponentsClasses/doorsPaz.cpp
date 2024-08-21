#include "doorsPaz.h"
#include <QDebug>
#include "canDataBase/canDataBase.h"

DoorsPaz::DoorsPaz(QObject *parent) : Doors(parent)
{

}

uint DoorsPaz::returnValveStatus(const int &_doorNumber){
    return 0;
//    canBus::messageNameCharStruct *EDSC2;
//    canBus::signalNameCharStruct *ValveOut;
//    canBus::signalNameCharStruct *ValveIn;
//    canBus::signalNameCharStruct *CapValveOut;
//    canBus::signalNameCharStruct *CapValveIn;
//    if (_doorNumber == 1) {
//        EDSC2 = new canBus::messageNameCharStruct(gMessageName_EDSC2_1);
//        ValveOut = new canBus::signalNameCharStruct(gSignalName_EmergencyCraneOut_1);
//        ValveIn = new canBus::signalNameCharStruct(gSignalName_EmergencyCraneIn_1);
//        CapValveOut = new canBus::signalNameCharStruct(gSignalName_EmergencyCraneOutCap_1);
//        CapValveIn = new canBus::signalNameCharStruct(gSignalName_EmergencyCraneInCap_1);
//    }
//    else if (_doorNumber == 2) {
//        EDSC2 = new canBus::messageNameCharStruct(gMessageName_EDSC2_2);
//        ValveOut = new canBus::signalNameCharStruct(gSignalName_EmergencyCraneOut_2);
//        ValveIn = new canBus::signalNameCharStruct(gSignalName_EmergencyCraneIn_2);
//        CapValveOut = new canBus::signalNameCharStruct(gSignalName_EmergencyCraneOutCap_2);
//        CapValveIn = new canBus::signalNameCharStruct(gSignalName_EmergencyCraneInCap_2);
//    }
//    else{
//        qWarning() << "Wrong door number";
//        return 0;
//    }

//    uint valveInStatus = 0;
//    if (((gCanDB_ICAN.GetSignalValueUint32_t(*ValveIn, *EDSC2)) == 0) && ((gCanDB_ICAN.GetSignalValueUint32_t(*CapValveIn, *EDSC2)) == 0)) valveInStatus = 0;
//    else if (((gCanDB_ICAN.GetSignalValueUint32_t(*ValveIn, *EDSC2)) == 0) && ((gCanDB_ICAN.GetSignalValueUint32_t(*CapValveIn, *EDSC2)) == 1)) valveInStatus = 1;
//    else if (((gCanDB_ICAN.GetSignalValueUint32_t(*ValveIn, *EDSC2)) == 1) && ((gCanDB_ICAN.GetSignalValueUint32_t(*CapValveIn, *EDSC2)) == 0)) valveInStatus = 2;
//    else if (((gCanDB_ICAN.GetSignalValueUint32_t(*ValveIn, *EDSC2)) == 1) && ((gCanDB_ICAN.GetSignalValueUint32_t(*CapValveIn, *EDSC2)) == 1)) valveInStatus = 3;
//    else valveInStatus = 0;

//    uint valveOutStatus = 0;
//    if (((gCanDB_ICAN.GetSignalValueUint32_t(*ValveOut, *EDSC2)) == 0) && ((gCanDB_ICAN.GetSignalValueUint32_t(*CapValveOut, *EDSC2)) == 0)) valveOutStatus = 0;
//    else if (((gCanDB_ICAN.GetSignalValueUint32_t(*ValveOut, *EDSC2)) == 0) && ((gCanDB_ICAN.GetSignalValueUint32_t(*CapValveOut, *EDSC2)) == 1)) valveOutStatus = 1;
//    else if (((gCanDB_ICAN.GetSignalValueUint32_t(*ValveOut, *EDSC2)) == 1) && ((gCanDB_ICAN.GetSignalValueUint32_t(*CapValveOut, *EDSC2)) == 0)) valveOutStatus = 2;
//    else if (((gCanDB_ICAN.GetSignalValueUint32_t(*ValveOut, *EDSC2)) == 1) && ((gCanDB_ICAN.GetSignalValueUint32_t(*CapValveOut, *EDSC2)) == 1)) valveOutStatus = 3;
//    else valveOutStatus = 0;

//    uint valvesStatus = valveInStatus | (valveOutStatus << 4);

//    //qDebug() << "Door number=" << _doorNumber << "Status In valve" << valveInStatus << "Status Out valve" << valveOutStatus << "All Status valve" << valvesStatus;
//    return valvesStatus;
}

uint DoorsPaz::returnDoorStatus(const int &_doorNumber){
    canBus::messageNameCharStruct *canMsg;
    canBus::signalNameCharStruct *Open;
    canBus::signalNameCharStruct *Close;
    canBus::signalNameCharStruct *EmergencyOpeningFlag;
    canBus::signalNameCharStruct *AntiPinch;
    canBus::signalNameCharStruct *PassengerButton;
    canBus::signalNameCharStruct *DoorNotDefained;

    if (_doorNumber == 1) {
        canMsg = new canBus::messageNameCharStruct(gMessageName_DOZC_1);
        Open = new canBus::signalNameCharStruct(gSignalName_Door1Open);
        Close = new canBus::signalNameCharStruct(gSignalName_Door1Close);
        PassengerButton = new canBus::signalNameCharStruct(gSignalName_Door1RqOpenPas);
        EmergencyOpeningFlag = new canBus::signalNameCharStruct(gSignalName_Door1EmergencyOpening1);
        AntiPinch =  new canBus::signalNameCharStruct(gSignalName_Door1Pinching);
        DoorNotDefained =  new canBus::signalNameCharStruct(gSignalName_Door1NotDefine);
    }
    else if (_doorNumber == 2) {
        canMsg = new canBus::messageNameCharStruct(gMessageName_DOZC_2);
        Open = new canBus::signalNameCharStruct(gSignalName_Door2Open);
        Close = new canBus::signalNameCharStruct(gSignalName_Door2Close);
        PassengerButton = new canBus::signalNameCharStruct(gSignalName_Door2RqOpenPas);
        EmergencyOpeningFlag = new canBus::signalNameCharStruct(gSignalName_Door2EmergencyOpening1);
        AntiPinch =  new canBus::signalNameCharStruct(gSignalName_Door2Pinching);
        DoorNotDefained =  new canBus::signalNameCharStruct(gSignalName_Door2NotDefine);

    }
    else if (_doorNumber == 3) {
        return 0;
    }
    else{
        qWarning() << "Wrong door number - " << _doorNumber;
        return 0;
    }

    // 0 - close
    // 1 - reqOpen
    // 2 - open
    // 3 - EmgOpen
    // 4 - Jamming
    // 5 - doorNotDefined

    uint doorStatus = 0;
    if ((gCanDB.GetSignalValueUint32_t(*Close, *canMsg)) == 1) doorStatus = 0;
    if ((gCanDB.GetSignalValueUint32_t(*PassengerButton, *canMsg)) == 1) doorStatus = 1;
    if ((gCanDB.GetSignalValueUint32_t(*Open, *canMsg)) == 1) doorStatus = 2;
    if ((gCanDB.GetSignalValueUint32_t(*EmergencyOpeningFlag, *canMsg)) == 1) doorStatus = 3;
    if ((gCanDB.GetSignalValueUint32_t(*AntiPinch, *canMsg)) == 1) doorStatus = 4;
    if ((gCanDB.GetSignalValueUint32_t(*DoorNotDefained, *canMsg)) == 1) doorStatus = 5;

    return doorStatus;
}
