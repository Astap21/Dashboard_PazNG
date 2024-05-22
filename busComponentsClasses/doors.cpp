#include "doors.h"
#include <QTimer>
#include <QDebug>
#include "canDataBase/canDataBase.h"

Doors::Doors(QObject *parent) : PrimaryBusComponent(parent)
{
    door1State = 0;
    door2State = 0;

    valvesMap["valvesIn1State"] = 0;
    valvesMap["valvesIn2State"] = 0;
    valvesMap["valvesOut1State"] = 0;
    valvesMap["valvesOut2State"] = 0;

    autoClosing = 0;
    autoClosingTime = 25;
    autoOpening = 0;
    stepLightning = 0;
    stepLightningDistance = 25;
    passSensor = 0;

    QTimer *timerForTask = new QTimer();
    connect(timerForTask, &QTimer::timeout, this, &Doors::TaskForTimer);
    int timerPeriod_ms = 200;
    timerForTask->start(timerPeriod_ms);
}
void Doors::ReadStateFromCanDB(){
     previousComponentState = 0;
    //Door 1
    // 0 - close
    // 1 - reqOpen
    // 2 - open
    // 3 - EmgOpen
    // 4 - Jamming
    previousComponentState = door1State;
    door1State = returnDoorStatus(1);
    if (door1State != previousComponentState) sendDoor1StatusToQml(door1State);

    previousComponentState = door2State;
    door2State = returnDoorStatus(2);
    if (door2State != previousComponentState) sendDoor2StatusToQml(door2State);



    uint valves1State = returnValveStatus(1);
    uint valves2State = returnValveStatus(2);

    previousComponentState = valvesMap["valvesIn1State"];
    valvesMap["valvesIn1State"] = valves1State & 0x0F;
    if (valvesMap["valvesIn1State"] != previousComponentState) sendValveIn1StatusToQml (valvesMap["valvesIn1State"]);

    previousComponentState = valvesMap["valvesIn2State"];
    valvesMap["valvesIn2State"] = valves2State & 0x0F;
    if (valvesMap["valvesIn2State"] != previousComponentState) sendValveIn2StatusToQml (valvesMap["valvesIn2State"]);

    previousComponentState = valvesMap["valvesOut1State"];
    valvesMap["valvesOut1State"] = (valves1State & 0xF0) >> 4;
    if (valvesMap["valvesOut1State"] != previousComponentState) sendValveOut1StatusToQml (valvesMap["valvesOut1State"]);

    previousComponentState = valvesMap["valvesOut2State"];
    valvesMap["valvesOut2State"] = (valves2State & 0xF0) >> 4;
    if (valvesMap["valvesOut2State"] != previousComponentState) sendValveOut2StatusToQml (valvesMap["valvesOut2State"]);


    previousComponentState = leastOneCapIsOpen;
    uint previousComponentState1 = leastOneValveIsOpen;
    leastOneCapIsOpen = false;
    leastOneValveIsOpen = false;
    for (auto valveStatus:valvesMap){
        //qDebug() << valveStatus;
        if (valveStatus == 1 || valveStatus == 3) leastOneCapIsOpen = true;
        if (valveStatus == 2 || valveStatus == 3) leastOneValveIsOpen = true;
    }
    if (leastOneCapIsOpen != previousComponentState) sendLeastOneCapIsOpenToQml (leastOneCapIsOpen);
    if (leastOneValveIsOpen != previousComponentState1) sendLeastOneValveIsOpenToQml (leastOneValveIsOpen);
}

bool Doors::getPassControlDoor1(){
    return passControlDoor1;
}

bool Doors::getPassControlDoor2(){
    return passControlDoor2;
}

bool Doors::getAutoClosing(){
    return autoClosing;
    autoClosingTime = 0;
    autoOpening = 0;
    stepLightning = 0;
    stepLightningDistance = 0;
    passSensor = 0;
}
uint Doors::getAutoClosingTime(){
    return autoClosingTime;
}
bool Doors::getAutoOpening(){
    return autoOpening;
}
bool Doors::getStepLightning(){
    return stepLightning;
}
uint Doors::getStepLightningDistance(){
    return stepLightningDistance;
}
bool Doors::getPassSensor(){
    return passSensor;
}

void Doors::setPassControlDoor1(const bool& state){
    passControlDoor1 = state;
    qDebug() << "passControlDoor1 =" << passControlDoor1;
    //Добавить отправку в CAN
}

void Doors::setPassControlDoor2(const bool& state){
    passControlDoor2 = state;
    qDebug() << "passControlDoor2 =" << passControlDoor2;
    //Добавить отправку в CAN
}

void Doors::setAutoClosing(const bool& state){
    autoClosing = state;
    qDebug() << "autoClosing =" << autoClosing;
}
void Doors::setAutoClosingTime(const uint& inputUint){
    autoClosingTime = inputUint;
    qDebug() << "autoClosingTime =" << autoClosingTime;
}
void Doors::setAutoOpening(const bool& state){
    autoOpening = state;
    qDebug() << "autoOpening =" << autoOpening;
}
void Doors::setStepLightning (const bool& state){
    stepLightning = state;
    qDebug() << "doorStepLightning =" << stepLightning;
}

void Doors::setStepLightningDistance(const uint& inputUint){
    stepLightningDistance = inputUint;
    qDebug() << "stepLightningDistance =" << stepLightningDistance;
}
void Doors::setPassSensor(const bool& state){
    passSensor = state;
    qDebug() << "passSensor =" << passSensor;
}

void Doors::SendStateToQml(){
//    sendDoor1StatusToQml(door1State);
//    sendDoor2StatusToQml(door2State);

}
uint Doors::GetDoorState(const int& doorNumber){
    if (doorNumber == 1) return door1State;
    else if (doorNumber == 2) return door2State;
    else return 0;
}
uint Doors::returnValveStatus(const int &_doorNumber){
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
//        EDSC2 = new canBus::messageNameCharStruct(gMessageName_EDSC2_1);
//        ValveOut = new canBus::signalNameCharStruct(gSignalName_EmergencyCraneOut_1);
//        ValveIn = new canBus::signalNameCharStruct(gSignalName_EmergencyCraneIn_1);
//        CapValveOut = new canBus::signalNameCharStruct(gSignalName_EmergencyCraneOutCap_1);
//        CapValveIn = new canBus::signalNameCharStruct(gSignalName_EmergencyCraneInCap_1);
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
uint Doors::returnDoorStatus(const int &_doorNumber){
//    canBus::messageNameCharStruct *EDSC2;
//    canBus::signalNameCharStruct *PassengerInButton;
//    canBus::signalNameCharStruct *PassengerOutButton;
//    canBus::signalNameCharStruct *ActiveEdge1;
//    canBus::signalNameCharStruct *ActiveEdge2;
//    canBus::signalNameCharStruct *PhotoSensor;
//    canBus::signalNameCharStruct *DisabledPersonOutButton;

    canBus::messageNameCharStruct *canMsg;
    canBus::signalNameCharStruct *Open;
    canBus::signalNameCharStruct *Close;
    canBus::signalNameCharStruct *EmergencyOpeningFlag;
    canBus::signalNameCharStruct *AntiPinch;
    canBus::signalNameCharStruct *PassengerButton;
//    canBus::signalNameCharStruct *DoorOpenedWithoutCommand;
//    canBus::signalNameCharStruct *DoorCannotBeClosed;
//    canBus::signalNameCharStruct *DoorCannotBeOpened;
    canBus::signalNameCharStruct *DoorNotDefained;
    if (_doorNumber == 1) {
//        EDSC2 = new canBus::messageNameCharStruct(gMessageName_EDSC2_1);
//        PassengerInButton = new canBus::signalNameCharStruct(gSignalName_PassengerInButton_1);
//        PassengerOutButton = new canBus::signalNameCharStruct(gSignalName_PassengerOutButton_1);
//        ActiveEdge1 =  new canBus::signalNameCharStruct(gSignalName_ActiveEdge1_1);
//        ActiveEdge2 =  new canBus::signalNameCharStruct(gSignalName_ActiveEdge2_1);
//        PhotoSensor =  new canBus::signalNameCharStruct(gSignalName_PhotoSensor_1);
//        DisabledPersonOutButton =  new canBus::signalNameCharStruct(gSignalName_DisabledPersonOutButton_1);

        canMsg = new canBus::messageNameCharStruct(gMessageName_DOZC_1);
        Open = new canBus::signalNameCharStruct(gSignalName_Door1Open);
        Close = new canBus::signalNameCharStruct(gSignalName_Door1Close);
        PassengerButton = new canBus::signalNameCharStruct(gSignalName_Door1RqOpenPas);
        EmergencyOpeningFlag = new canBus::signalNameCharStruct(gSignalName_Door1EmergencyOpening1);
        AntiPinch =  new canBus::signalNameCharStruct(gSignalName_Door1Pinching);
        DoorNotDefained =  new canBus::signalNameCharStruct(gSignalName_Door1NotDefine);
//        DoorOpenedWithoutCommand =  new canBus::signalNameCharStruct(gSignalName_DoorOpenedWithoutCommand_1);
//        DoorCannotBeClosed =  new canBus::signalNameCharStruct(gSignalName_DoorCannotBeClosed_1);
//        DoorCannotBeOpened =  new canBus::signalNameCharStruct(gSignalName_DoorCannotBeOpened_1);
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
    else{
//        EDSC2 = new canBus::messageNameCharStruct(gMessageName_EDSC2_1);
//        PassengerInButton = new canBus::signalNameCharStruct(gSignalName_PassengerInButton_1);
//        PassengerOutButton = new canBus::signalNameCharStruct(gSignalName_PassengerOutButton_1);
//        ActiveEdge1 =  new canBus::signalNameCharStruct(gSignalName_ActiveEdge1_1);
//        ActiveEdge2 =  new canBus::signalNameCharStruct(gSignalName_ActiveEdge2_1);
//        PhotoSensor =  new canBus::signalNameCharStruct(gSignalName_PhotoSensor_1);
//        DisabledPersonOutButton =  new canBus::signalNameCharStruct(gSignalName_DisabledPersonOutButton_1);

        canMsg = new canBus::messageNameCharStruct(gMessageName_DOZC_1);
        Open = new canBus::signalNameCharStruct(gSignalName_Door1Open);
        Close = new canBus::signalNameCharStruct(gSignalName_Door1Close);
        PassengerButton = new canBus::signalNameCharStruct(gSignalName_Door1RqOpenPas);
        EmergencyOpeningFlag = new canBus::signalNameCharStruct(gSignalName_Door1EmergencyOpening1);
        AntiPinch =  new canBus::signalNameCharStruct(gSignalName_Door1Pinching);
        DoorNotDefained =  new canBus::signalNameCharStruct(gSignalName_Door1NotDefine);
//        DoorOpenedWithoutCommand =  new canBus::signalNameCharStruct(gSignalName_DoorOpenedWithoutCommand_1);
//        DoorCannotBeClosed =  new canBus::signalNameCharStruct(gSignalName_DoorCannotBeClosed_1);
//        DoorCannotBeOpened =  new canBus::signalNameCharStruct(gSignalName_DoorCannotBeOpened_1);
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

//    if ((gCanDB_ICAN.GetSignalValueUint32_t(*PassengerInButton, *EDSC2)) == 1) doorStatus = 1;
//    if ((gCanDB_ICAN.GetSignalValueUint32_t(*PassengerOutButton, *EDSC2)) == 1) doorStatus = 1;
//    if ((gCanDB_ICAN.GetSignalValueUint32_t(*DisabledPersonOutButton, *EDSC2)) == 1) doorStatus = 1;

    if ((gCanDB.GetSignalValueUint32_t(*Open, *canMsg)) == 1) doorStatus = 2;

    if ((gCanDB.GetSignalValueUint32_t(*EmergencyOpeningFlag, *canMsg)) == 1) doorStatus = 3;
    if ((gCanDB.GetSignalValueUint32_t(*AntiPinch, *canMsg)) == 1) doorStatus = 4;
//    if ((gCanDB_ICAN.GetSignalValueUint32_t(*DoorCannotBeClosed, *EDSC1)) == 1) doorStatus = 4;
//    if ((gCanDB_ICAN.GetSignalValueUint32_t(*DoorCannotBeOpened, *EDSC1)) == 1) doorStatus = 4;
//    if ((gCanDB_ICAN.GetSignalValueUint32_t(*ActiveEdge1, *EDSC2)) == 1) doorStatus = 4;
//    if ((gCanDB_ICAN.GetSignalValueUint32_t(*ActiveEdge2, *EDSC2)) == 1) doorStatus = 4;
//    if ((gCanDB_ICAN.GetSignalValueUint32_t(*PhotoSensor, *EDSC2)) == 1) doorStatus = 4;

//    if ((gCanDB_ICAN.GetSignalValueUint32_t(*Open, *EDSC1)) == 6) doorStatus = 5;
    if ((gCanDB.GetSignalValueUint32_t(*DoorNotDefained, *canMsg)) == 1) doorStatus = 5;

    return doorStatus;
}
void Doors::dashboardLoadFinished(){
    sendValveIn1StatusToQml (valvesMap["valvesIn1State"]);
    sendValveIn2StatusToQml (valvesMap["valvesIn2State"]);
    sendValveOut1StatusToQml (valvesMap["valvesOut1State"]);
    sendValveOut2StatusToQml (valvesMap["valvesOut2State"]);

    leastOneCapIsOpen = false;
    leastOneValveIsOpen = false;
    for (auto valveStatus:valvesMap){
        //qDebug() << valveStatus;
        if (valveStatus == 1 || valveStatus == 3) leastOneCapIsOpen = true;
        if (valveStatus == 2 || valveStatus == 3) leastOneValveIsOpen = true;
    }
    sendLeastOneCapIsOpenToQml (leastOneCapIsOpen);
    sendLeastOneValveIsOpenToQml (leastOneValveIsOpen);
}
