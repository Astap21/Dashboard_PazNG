#include "energyconsumption.h"
#include <QTimer>
#include "canDataBase/canDataBase.h"

EnergyConsumption::EnergyConsumption(QObject *parent) : PrimaryBusComponent(parent)
{
//    climatSystemTotalEnergyCons = 0;
//    climatSystemDailyEnergyCons = 0;
//    allConsumersTotalEnergyCons = 0;
//    allConsumersDailyEnergyCons = 0;
//    tractionSystemTotalEnergyCons = 0;
//    tractionSystemDailyEnergyCons = 0;
//    chargingTotalEnergy = 0;
//    chargingDailyEnergy = 0;
//    recuperationTotalEnergy = 0;
//    recuperationDailyEnergy = 0;

    timerPeriod_ms = 300;
    timerForTask.setInterval(timerPeriod_ms);
}
void EnergyConsumption::ReadStateFromCanDB(){
    checkSendSignalChg001(gCanDB.GetSignalValueFloat(gSignalName_Energy_for_traction_total, gMessageName_TTS6), EnergyForTractionTotal, [&](int value) { emit sendEnergyForTractionTotal(value);});
    checkSendSignalChg001(gCanDB.GetSignalValueFloat(gSignalName_Energy_for_traction_daily, gMessageName_TTS6), EnergyForTractionDaily, [&](int value) { emit sendEnergyForTractionDaily(value);});
    checkSendSignalChg001(gCanDB.GetSignalValueFloat(gSignalName_Energy_with_recuperation_total, gMessageName_TTS7), EnergyWithRecuperationTotal, [&](int value) { emit sendEnergyWithRecuperationTotal(value);});
    checkSendSignalChg001(gCanDB.GetSignalValueFloat(gSignalName_Energy_with_recuperation_daily, gMessageName_TTS7), EnergyWithRecuperationDaily, [&](int value) { emit sendEnergyWithRecuperationDaily(value);});
    checkSendSignalChg001(gCanDB.GetSignalValueFloat(gSignalName_Energy_recuperation_total, gMessageName_TTS8), EnergyRecuperationTotal, [&](int value) { emit sendEnergyRecuperationTotal(value);});
    checkSendSignalChg001(gCanDB.GetSignalValueFloat(gSignalName_Energy_recuperation_daily, gMessageName_TTS9), EnergyRecuperationDaily, [&](int value) { emit sendEnergyRecuperationDaily(value);});
    checkSendSignalChg001(gCanDB.GetSignalValueFloat(gSignalName_Ratio_recup_to_energy_total, gMessageName_TTS8), RatioRecupToEnergyTotal, [&](int value) { emit sendRatioRecupToEnergyTotal(value);});
    checkSendSignalChg001(gCanDB.GetSignalValueFloat(gSignalName_Ratio_recup_to_energy_daily, gMessageName_TTS9), RatioRecupToEnergyDaily, [&](int value) { emit sendRatioRecupToEnergyDaily(value);});
    //    climatSystemTotalEnergyCons = gCanDB_ICAN.GetSignalValueFloat(gSignalName_TotalEnergyConsump, gMessageName_AirCondEnergyConsumption);
    //climatSystemDailyEnergyCons = gCanDB_ICAN.GetSignalValue(gSignalName_DCDCWorkingStatus,gMessageName_AirCondEnergyConsumption);

    // 0 - TotalEnergyCons; 1 - TractionlEnergyCons; 2 - ChargingEnergy; 3 - RecuperationEnergy;
//    uint energyConsumerIDTotal = (gCanDB_ICAN.GetSignalValueUint32_t(gSignalName_ParameterIDTotal, gMessageName_EnergyCons));
//    float totalEnergyForActualId = (gCanDB_ICAN.GetSignalValueFloat(gSignalName_EnergyTotal, gMessageName_EnergyCons));
//    uint energyConsumerIDDaily = (gCanDB_ICAN.GetSignalValueUint32_t(gSignalName_ParameterIDDaily, gMessageName_EnergyCons));
//    float dailyEnergyForActualId = (gCanDB_ICAN.GetSignalValueFloat(gSignalName_EnergyDaily, gMessageName_EnergyCons));

//    if (energyConsumerIDTotal == 0) allConsumersTotalEnergyCons = totalEnergyForActualId;
//    if (energyConsumerIDTotal == 1) tractionSystemTotalEnergyCons = totalEnergyForActualId;
//    if (energyConsumerIDTotal == 2) chargingTotalEnergy = totalEnergyForActualId;
//    if (energyConsumerIDTotal == 3) recuperationTotalEnergy = totalEnergyForActualId;

//    if (energyConsumerIDDaily == 0) allConsumersDailyEnergyCons = dailyEnergyForActualId;
//    if (energyConsumerIDDaily == 1) tractionSystemDailyEnergyCons = dailyEnergyForActualId;
//    if (energyConsumerIDDaily == 2) chargingDailyEnergy = dailyEnergyForActualId;
//    if (energyConsumerIDDaily == 3) recuperationDailyEnergy = dailyEnergyForActualId;
}
//void EnergyConsumption::SendStateToQml(){
//    emit sendEnergyClimatTotalToQml(climatSystemTotalEnergyCons);
//    //sendEnergyClimatDailyToQml();
//    emit sendEnergyAllConsumersTotalToQml(allConsumersTotalEnergyCons);
//    emit sendEnergyTractionTotalToQml(tractionSystemTotalEnergyCons);
//    emit sendEnergyChargingTotalToQml(chargingTotalEnergy);
//    emit sendEnergyRecuperationTotalToQml(recuperationTotalEnergy);

//    emit sendEnergyAllConsumersDailyToQml(allConsumersDailyEnergyCons);
//    emit sendEnergyTractionDailyToQml(tractionSystemDailyEnergyCons);
//    emit sendEnergyChargingDailyToQml(chargingDailyEnergy);
//    emit sendEnergyRecuperationDailyToQml(recuperationDailyEnergy);
//}

void EnergyConsumption::dashboardLoadFinished(){
    emit sendEnergyForTractionTotal(EnergyForTractionTotal);
    emit sendEnergyForTractionDaily(EnergyForTractionDaily);
    emit sendEnergyWithRecuperationTotal(EnergyWithRecuperationTotal);
    emit sendEnergyWithRecuperationDaily(EnergyWithRecuperationDaily);
    emit sendEnergyRecuperationTotal(EnergyRecuperationTotal);
    emit sendEnergyRecuperationDaily(EnergyRecuperationDaily);
    emit sendRatioRecupToEnergyTotal(RatioRecupToEnergyTotal);
    emit sendRatioRecupToEnergyDaily(RatioRecupToEnergyDaily);
}
float EnergyConsumption::getEnergyForTractionTotal(void){
    return EnergyForTractionTotal;
}
float EnergyConsumption::getEnergyForTractionDaily(void){
    return EnergyForTractionDaily;
}
float EnergyConsumption::getEnergyWithRecuperationTotal(void){
    return EnergyWithRecuperationTotal;
}
float EnergyConsumption::getEnergyWithRecuperationDaily(void){
    return EnergyWithRecuperationDaily;
}
float EnergyConsumption::getEnergyRecuperationTotal(void){
    return EnergyRecuperationTotal;
}
float EnergyConsumption::getEnergyRecuperationDaily(void){
    return EnergyRecuperationDaily;
}
float EnergyConsumption::getRatioRecupToEnergyTotal(void){
    return RatioRecupToEnergyTotal;
}
float EnergyConsumption::getRatioRecupToEnergyDaily(void){
    return RatioRecupToEnergyDaily;
}
