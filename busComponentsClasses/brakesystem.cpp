#include "brakesystem.h"
#include "canDataBase/canDataBase.h"
#include <QTimer>
#include <QDebug>

BrakeSystem::BrakeSystem(QObject *parent) : PrimaryBusComponent(parent)
{
    timerPeriod_ms = 100;
    timerForTask.setInterval(timerPeriod_ms);

    pressureCircuit1_bar = 0;
    pressureCircuit1_Indication = 0;
    pressureCircuit2_bar = 0;
    pressureCircuit2_Indication = 0;
    pressureCircuit3_Indication = 0;
    pressureCircuit4_Indication = 0;
    minBrakePadsIndication = 0;
    retarderPercent = 0;
    reqStopSound = 0;

    EBS_Indication = 0;
    ASR_Indication = 0;
    ESC_Indication = 0;
    TractionControl = 0;
    HaltBrake_Indication = 0;
    parkingBrake_Indication = 0;
    pressureParkingBrake_bar = 0;

    frontLeftBrakePads_Percent = 0;
    frontRightBrakePads_Percent= 0;
    rearLeftBrakePads_Percent = 0;
    rearRightBrakePads_Percent = 0;
    brakePedalPosition = 0;

    tire_00 = new Tire (0x0, 0x0);
    connect(tire_00, &Tire::sendPressureTireToQml, this, &BrakeSystem::sendPressureFrontLeftTireToQml);
    connect(tire_00, &Tire::sendTempTireToQml, this, &BrakeSystem::sendTempFrontLeftTireToQml);

    tire_01 = new Tire (0x1, 0x0);
    connect(tire_01, &Tire::sendPressureTireToQml, this, &BrakeSystem::sendPressureRearLeftTire1ToQml);
    connect(tire_01, &Tire::sendTempTireToQml, this, &BrakeSystem::sendTempRearLeftTire1ToQml);

    tire_11 = new Tire (0x1, 0x1);
    connect(tire_11, &Tire::sendPressureTireToQml, this, &BrakeSystem::sendPressureRearLeftTire2ToQml);
    connect(tire_11, &Tire::sendTempTireToQml, this, &BrakeSystem::sendTempRearLeftTire2ToQml);

    tire_10 = new Tire (0x0, 0x1);
    connect(tire_10, &Tire::sendPressureTireToQml, this, &BrakeSystem::sendPressureFrontRightTireToQml);
    connect(tire_10, &Tire::sendTempTireToQml, this, &BrakeSystem::sendTempFrontRightTireToQml);

    tire_12 = new Tire (0x1, 0x2);
    connect(tire_12, &Tire::sendPressureTireToQml, this, &BrakeSystem::sendPressureRearRightTire1ToQml);
    connect(tire_12, &Tire::sendTempTireToQml, this, &BrakeSystem::sendTempRearRightTire1ToQml);

    tire_13 = new Tire (0x1, 0x3);
    connect(tire_13, &Tire::sendPressureTireToQml, this, &BrakeSystem::sendPressureRearRightTire2ToQml);
    connect(tire_13, &Tire::sendTempTireToQml, this, &BrakeSystem::sendTempRearRightTire2ToQml);

    tires.push_back(tire_00);
    tires.push_back(tire_01);
    tires.push_back(tire_11);
    tires.push_back(tire_10);
    tires.push_back(tire_12);
    tires.push_back(tire_13);
    tireIndication = 0;
}
void BrakeSystem::ReadStateFromCanDB(){

    //if (checkValueChange(getNewValueFromOneCanSignalU32(gSignalName_reqStopSound, gMessageName_MUX_to_EVCU_System, &gCanDB), reqStopSound)) emit sendReqStopSoundToQml(reqStopSound);

    //brakePedalPosition = gCanDB.GetSignalValueFloat(gSignalName_BrakePedalPos,gMessageName_EBC1);
    //emit sendBrakePedalPositionStatusToQml(brakePedalPosition);
    if (checkValueChange(uint(getNewValueFromOneCanSignalU32(gSignalName_AirCompressorStatus, gMessageName_AIR1, &gCanDB)), compressorState)) emit sendCompressorStateToQml(compressorState);

    previousComponentState = 0;
    //kpa->bar
    float pressure_kpa = gCanDB.GetSignalValueFloat(gSignalName_ServiceBrakeCircuit1AirPress,gMessageName_AIR1);
    if (checkValueChangeBy_01(pressure_kpa / 98.066f, pressureCircuit1_bar)){
        //qDebug() << pressureCircuit1_bar;
        emit sendPressureCircuit1ToQml(pressureCircuit1_bar);
    }
    //qDebug() << pressure_kpa;
    previousComponentState = pressureCircuit1_Indication;
    float lowBarPressure = 6;
    if (pressureCircuit1_bar < lowBarPressure) pressureCircuit1_Indication = 1;
    else pressureCircuit1_Indication = 0;
    if (pressureCircuit1_Indication != previousComponentState) emit sendPressureCircuit1LampToQml(pressureCircuit1_Indication);

    previousComponentState = pressureCircuit2_Indication;
    pressure_kpa = gCanDB.GetSignalValueFloat(gSignalName_ServiceBrakeCircuit2AirPress, gMessageName_AIR1);
    if (checkValueChangeBy_01(pressure_kpa / 98.066f, pressureCircuit2_bar)){
        emit sendPressureCircuit2ToQml(pressureCircuit2_bar);
    }
    if (pressureCircuit2_bar < lowBarPressure) pressureCircuit2_Indication = 1;
    else pressureCircuit2_Indication = 0;
    if (pressureCircuit2_Indication != previousComponentState) emit sendPressureCircuit2LampToQml(pressureCircuit2_Indication);

    previousComponentState = pressureCircuit3_Indication;
    pressure_kpa = gCanDB.GetSignalValueFloat(gSignalName_ParkingAirPressure, gMessageName_AIR1);
    float pressureCircuit3_bar = pressure_kpa / 98.066f;
    if (pressureCircuit3_bar < lowBarPressure) pressureCircuit3_Indication = 1;
    else pressureCircuit3_Indication = 0;
    if (pressureCircuit3_Indication != previousComponentState) emit sendPressureCircuit3LampToQml(pressureCircuit3_Indication);

    previousComponentState = pressureCircuit4_Indication;
    pressure_kpa = gCanDB.GetSignalValueFloat(gSignalName_AuxiliaryEquipmentSupplyPressure, gMessageName_AIR1);
    float pressureCircuit4_bar = pressure_kpa / 98.066f;
    if (pressureCircuit4_bar < lowBarPressure) pressureCircuit4_Indication = 1;
    else pressureCircuit4_Indication = 0;
    if (pressureCircuit4_Indication != previousComponentState) emit sendPressureCircuit4LampToQml(pressureCircuit4_Indication);

    previousComponentState = EBS_Indication;
    if (gCanDB.GetSignalValueUint32_t(gSignalName_EBS_RedLamp, gMessageName_EBC1) == canBus::canSignalStateStructObj.on) EBS_Indication = EBS_Lamp.redLamp;
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_EBS_WarningLamp, gMessageName_EBC1) == canBus::canSignalStateStructObj.on) EBS_Indication = EBS_Lamp.yellowLamp;
    else EBS_Indication = EBS_Lamp.off;
    uint32_t CountMissedMessages = gCanDB.CheckNumberMissedMessages(gCanDB.GetMessageId(gMessageName_EBC1));
    uint32_t limitMissedMessages = 5;
    if (CountMissedMessages > limitMissedMessages){
        EBS_Indication = EBS_Lamp.redLampFlashing;
    }
    if (EBS_Indication != previousComponentState) {
        emit sendEBS_IndicationToQml(EBS_Indication);
    }
    //qDebug() << EBS_Indication;

    previousComponentState = TractionControl;
    if (gCanDB.GetSignalValueUint32_t(gSignalName_TractionControlOverrideSwitch, gMessageName_EBC1) == canBus::canSignalStateStructObj.on){
        TractionControl = 1;
    }
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_TractionControlOverrideSwitch, gMessageName_EBC1) == canBus::canSignalStateStructObj.error){
        TractionControl = 2;
    }
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_ASR_infoSignal, gMessageName_EBC1) == canBus::canSignalStateStructObj.on){
        TractionControl = 3;
    }
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_ASR_infoSignal, gMessageName_EBC1) == canBus::canSignalStateStructObj.error){
        TractionControl = 4;
    }
    else{
        TractionControl = 0;
    }
    if (TractionControl != previousComponentState) emit sendTractionControlToQml(TractionControl);

    previousComponentState = ASR_Indication;
    if ((gCanDB.GetSignalValueUint32_t(gSignalName_ASR_EngineControlActive, gMessageName_EBC1) == 1) &&
       (gCanDB.GetSignalValueUint32_t(gSignalName_ASR_infoSignal, gMessageName_EBC1) == 1)) {
            ASR_Indication = 1;
    }
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_ASR_BrakeControlActive, gMessageName_EBC1) == 1) &&
       (gCanDB.GetSignalValueUint32_t(gSignalName_ASR_infoSignal, gMessageName_EBC1) == 1)) {
            ASR_Indication = 1;
    }
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_ASR_OffRoadSwitch, gMessageName_EBC1) == 1) &&
       (gCanDB.GetSignalValueUint32_t(gSignalName_ASR_infoSignal, gMessageName_EBC1) == 1)) {
            ASR_Indication = 2;
    }
    else{
        ASR_Indication = 0;
    }
    if (ASR_Indication != previousComponentState) {
        emit sendASR_IndicationToQml(ASR_Indication);
    }

    previousComponentState = ESC_Indication;
    if ((gCanDB.GetSignalValueUint32_t(gSignalName_VDC_InformationSignal, gMessageName_VDC1) == 1) &&
            (gCanDB.GetSignalValueUint32_t(gSignalName_ASR_OffRoadSwitch, gMessageName_EBC1) == 1))
    {
            ESC_Indication = ESC_Lamp.lampESC_Off;
    }
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_VDC_InformationSignal, gMessageName_VDC1) == 1) &&
            (gCanDB.GetSignalValueUint32_t(gSignalName_VDC_FullyOperational, gMessageName_VDC1) == 1))
    {
            ESC_Indication = ESC_Lamp.toggleLampESC_On;
    }
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_VDC_InformationSignal, gMessageName_VDC1) == 1) &&
            (gCanDB.GetSignalValueUint32_t(gSignalName_VDC_FullyOperational, gMessageName_VDC1) == 0)&&
            (gCanDB.GetSignalValueUint32_t(gSignalName_ASR_OffRoadSwitch, gMessageName_EBC1) == 0))
    {
            ESC_Indication = ESC_Lamp.lampESC_On;
    }
    else {
        ESC_Indication = ESC_Lamp.off;
    }
    if (ESC_Indication != previousComponentState) {
        emit sendESC_IndicationToQml(ESC_Indication);
    }


    previousComponentState = HillHolder_Indication;
    if ((gCanDB.GetSignalValueUint32_t(gSignalName_HillHolderMode, gMessageName_EBC5)) == 2.0f) HillHolder_Indication = HillHolderLamp.toggleLampHH_On;
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_HillHolderMode, gMessageName_EBC5)) == 1.0f) HillHolder_Indication = HillHolderLamp.LampHH_On;
    else HillHolder_Indication = HillHolderLamp.off;
    if (HillHolder_Indication != previousComponentState) emit sendHillHolderIndicationToQml(HillHolder_Indication);

    if (checkValueChange(uint(getNewValueFromOneCanSignalU32(gSignalName_HaltBrakeMode, gMessageName_EBC5, &gCanDB)), HaltBrake_Indication)) emit sendHaltBrakeStatusToQml(HaltBrake_Indication);

    previousComponentState = parkingBrake_Indication;
    //qDebug() << parkingBrake_Indication;
//    pressure_kpa = gCanDB.GetSignalValueFloat(gSignalName_ParkingAirPressure, gMessageName_AIR1);
//    pressureParkingBrake_bar = pressure_kpa / 98.066f;
//    if (pressureParkingBrake_bar < lowBarPressure) {
//        parkingBrake_Indication = 1;
//    }
    if (gCanDB.GetSignalValueUint32_t(gSignalName_ParkingBrakeState, gMessageName_CCVS1) == 1) {
        parkingBrake_Indication = 2;
    }
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_ParkingWorkStatus1, gMessageName_EPBS1)) == 2 &&
             (gCanDB.GetSignalValueUint32_t(gSignalName_ParkingWorkStatus2, gMessageName_EPBS1)) == 1) {
        parkingBrake_Indication = 3;
    }
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_ParkingWorkStatus1, gMessageName_EPBS1)) == 1 &&
             (gCanDB.GetSignalValueUint32_t(gSignalName_ParkingWorkStatus2, gMessageName_EPBS1)) == 1) {
        parkingBrake_Indication = 4;
    }
    else if (gCanDB.GetSignalValueUint32_t(gSignalName_EPB_Error, gMessageName_DM1_EPB) == 1) {
        parkingBrake_Indication = 5;
    }
    else {
        parkingBrake_Indication = 0;
    }
    if (parkingBrake_Indication != previousComponentState) {
        emit sendPressureCircuitParkBrakeToQml(parkingBrake_Indication);
    }

    if (checkValueChangeBy_1(gCanDB.GetSignalValueFloat(gSignalName_FrontAxleLeft,gMessageName_EBC4), frontLeftBrakePads_Percent)){
        emit sendFrontLeftBrakePercentToQml(frontLeftBrakePads_Percent);
    }
    if (checkValueChangeBy_1(gCanDB.GetSignalValueFloat(gSignalName_FrontAxleRight, gMessageName_EBC4), frontRightBrakePads_Percent)){
        emit sendFrontRightBrakePercentToQml(frontRightBrakePads_Percent);
    }
    if (checkValueChangeBy_1(gCanDB.GetSignalValueFloat(gSignalName_RearAxle1LeftWheel, gMessageName_EBC4), rearLeftBrakePads_Percent)){
        emit sendRearLeftBrakePercentToQml(rearLeftBrakePads_Percent);
    }
    if (checkValueChangeBy_1(gCanDB.GetSignalValueFloat(gSignalName_RearAxle1RightWheel, gMessageName_EBC4), rearRightBrakePads_Percent)){
        emit sendRearRightBrakePercentToQml(rearRightBrakePads_Percent);
    }
    float minBrakePadsPercent = 100;
    if (minBrakePadsPercent > frontLeftBrakePads_Percent) minBrakePadsPercent = frontLeftBrakePads_Percent;
    if (minBrakePadsPercent > frontRightBrakePads_Percent) minBrakePadsPercent = frontRightBrakePads_Percent;
    if (minBrakePadsPercent > rearLeftBrakePads_Percent)  minBrakePadsPercent = rearLeftBrakePads_Percent;
    if (minBrakePadsPercent > rearRightBrakePads_Percent)  minBrakePadsPercent = rearRightBrakePads_Percent;
    previousComponentState = minBrakePadsIndication;
    if (minBrakePadsPercent < lowBrakePads_Percent) {
        minBrakePadsIndication = 1;
    }
    else {
        minBrakePadsIndication = 0;
    }
    if (minBrakePadsIndication != previousComponentState) emit sendLowBrakePadsToQml(minBrakePadsIndication);

    previousComponentState = tireIndication;
    for (auto& tire:tires){
        if (tire->getPressure() <= lowTirePressure || tire->getPressure() >= highTirePressure || tire->getTemp() >= highTireTemp) {
            tireIndication = true;
            break;
        }
        else tireIndication = false;
    }
    if (tireIndication != previousComponentState) {
        emit sendLowTirePressureToQml(tireIndication);
    }

//    if (checkValueChangeBy_1(gCanDB.GetSignalValueFloat(gSignalName_RetarderBrake,gMessageName_ERC1), retarderPercent)){
//        emit sendRetarderPercentToQml(retarderPercent);
//    }
    previousComponentState = movementsBan;
    if ((parkingBrake_Indication == 1) || pressureCircuit1_Indication || pressureCircuit2_Indication || pressureCircuit3_Indication || pressureCircuit4_Indication){
        movementsBan = 1;
    }
    else{
        movementsBan = 0;
    }
    if (movementsBan != previousComponentState) {
        emit sendMovementsBanState(movementsBan);
    }
}
void BrakeSystem::SendStateToQml(){

}
void BrakeSystem::dashboardLoadFinished(){
    emit sendCompressorStateToQml(compressorState);
    emit sendTractionControlToQml(TractionControl);
    emit sendEBS_IndicationToQml(EBS_Indication);
    emit sendASR_IndicationToQml(ASR_Indication);
    emit sendESC_IndicationToQml(ESC_Indication);
    emit sendHillHolderIndicationToQml(HillHolder_Indication);
    emit sendHaltBrakeStatusToQml(HaltBrake_Indication);
    emit sendLowBrakePadsToQml(minBrakePadsIndication);
    emit sendPressureCircuitParkBrakeToQml(parkingBrake_Indication);
    emit sendPressureCircuit1LampToQml(pressureCircuit1_Indication);
    emit sendPressureCircuit2LampToQml(pressureCircuit2_Indication);
    emit sendPressureCircuit3LampToQml(pressureCircuit3_Indication);
    emit sendPressureCircuit4LampToQml(pressureCircuit4_Indication);
    emit sendLowTirePressureToQml(tireIndication);
//    emit sendLowTirePressureToQml(false);

    emit sendPressureCircuit1ToQml(pressureCircuit1_bar);
    emit sendPressureCircuit2ToQml(pressureCircuit2_bar);
}
float BrakeSystem::getLowTirePressure(){return lowTirePressure;}
float BrakeSystem::getHighTirePressure(){return highTirePressure;}
float BrakeSystem::getHighTireTemp(){return highTireTemp;}
float BrakeSystem::getLowBrakePads_Percent(){return lowBrakePads_Percent;}
