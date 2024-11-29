#include "climate_system.h"
#include "canDataBase/canDataBase.h"
climate_system::climate_system()
{
    timerPeriod_ms = 500;
    timerForTask.setInterval(timerPeriod_ms);
}
void climate_system::ReadStateFromCanDB(){
    checkSendSignalChg1(gCanDB.GetSignalValueInt(gSignalName_ElectricEngineTemp, gMessageName_MCU2VCU2), EngineTemp, [&](int value) { emit sendEngineTemp(value);});
    checkSendSignalChg1(gCanDB.GetSignalValueInt(gSignalName_SalonTemp_1, gMessageName_CCUT1), MeasuredTemp1, [&](int value) { emit sendMeasuredTemp1(value);});
    checkSendSignalChg1(gCanDB.GetSignalValueInt(gSignalName_SalonTemp_2, gMessageName_CCUT1), MeasuredTemp2, [&](int value) { emit sendMeasuredTemp2(value);});
    checkSendSignalChg1(gCanDB.GetSignalValueInt(gSignalName_SalonTemp_3, gMessageName_CCUT1), MeasuredTemp3, [&](int value) { emit sendMeasuredTemp3(value);});
    checkSendSignalChg1(gCanDB.GetSignalValueInt(gSignalName_InletWaterTemp, gMessageName_T2B_TMS1), InletWaterTemp, [&](int value) { emit sendInletWaterTemp(value);});
    checkSendSignalChg1(gCanDB.GetSignalValueInt(gSignalName_OutletWaterTemp, gMessageName_T2B_TMS1), OutletWaterTemp, [&](int value) { emit sendOutletWaterTemp(value);});
    checkSendSignalChg1(gCanDB.GetSignalValueInt(gSignalName_TMS_FaultCode, gMessageName_T2B_TMS1), FaultCodeTMS, [&](int value) { emit sendFaultCodeTMS(value);});
    checkSendSignalChg001(gCanDB.GetSignalValueFloat(gSignalName_HighestCellTemp, gMessageName_HVESSD3), HighestCellTemp, [&](int value) { emit sendHighestCellTemp(value);});
    checkSendSignalChg001(gCanDB.GetSignalValueFloat(gSignalName_LowestCellTemp, gMessageName_HVESSD3), LowestCellTemp, [&](int value) { emit sendLowestCellTemp(value);});
    checkSendSignalChg001(gCanDB.GetSignalValueFloat(gSignalName_AverageCellTemp, gMessageName_HVESSD3), AverageCellTemp, [&](int value) { emit sendAverageCellTemp(value);});
    checkSendSignalChg1(gCanDB.GetSignalValueInt(gSignalName_ElectronicTemp, gMessageName_HVESSD6), ElectronicsTemp, [&](int value) { emit sendElectronicsTemp(value);});
}
void climate_system::dashboardLoadFinished(){
    emit sendEngineTemp(EngineTemp);
    emit sendMeasuredTemp1(MeasuredTemp1);
    emit sendMeasuredTemp2(MeasuredTemp2);
    emit sendMeasuredTemp3(MeasuredTemp3);
    emit sendInletWaterTemp(InletWaterTemp);
    emit sendOutletWaterTemp(OutletWaterTemp);
    emit sendFaultCodeTMS(FaultCodeTMS);
    emit sendHighestCellTemp(HighestCellTemp);
    emit sendLowestCellTemp(LowestCellTemp);
    emit sendAverageCellTemp(AverageCellTemp);
    emit sendElectronicsTemp(ElectronicsTemp);
}
int climate_system::getEngineTemp(void){
    return EngineTemp;
}
int climate_system::getMeasuredTemp1(void){
    return MeasuredTemp1;
}
int climate_system::getMeasuredTemp2(void){
    return MeasuredTemp2;
}
int climate_system::getMeasuredTemp3(void){
    return MeasuredTemp3;
}
int climate_system::getInletWaterTemp(void){
    return InletWaterTemp;
}
int climate_system::getOutletWaterTemp(void){
    return OutletWaterTemp;
}
int climate_system::getFaultCodeTMS(void){
    return FaultCodeTMS;
}
float climate_system::getHighestCellTemp(void){
    return HighestCellTemp;
}
float climate_system::getLowestCellTemp(void){
    return LowestCellTemp;
}
float climate_system::getAverageCellTemp(void){
    return AverageCellTemp;
}
int climate_system::getElectronicsTemp(void){
    return ElectronicsTemp;
}
