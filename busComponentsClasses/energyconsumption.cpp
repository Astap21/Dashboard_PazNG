#include "energyconsumption.h"
#include <QTimer>
#include "can/can_bus.h"

EnergyConsumption::EnergyConsumption(QObject *parent) : PrimaryBusComponent(parent)
{
    climatSystemTotalEnergyCons = 0;
    climatSystemDailyEnergyCons = 0;
    allConsumersTotalEnergyCons = 0;
    allConsumersDailyEnergyCons = 0;
    tractionSystemTotalEnergyCons = 0;
    tractionSystemDailyEnergyCons = 0;
    chargingTotalEnergy = 0;
    chargingDailyEnergy = 0;
    recuperationTotalEnergy = 0;
    recuperationDailyEnergy = 0;

    timerPeriod_ms = 300;
    timerForTask.setInterval(timerPeriod_ms);
}
void EnergyConsumption::ReadStateFromCanDB(){
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
void EnergyConsumption::SendStateToQml(){
    emit sendEnergyClimatTotalToQml(climatSystemTotalEnergyCons);
    //sendEnergyClimatDailyToQml();
    emit sendEnergyAllConsumersTotalToQml(allConsumersTotalEnergyCons);
    emit sendEnergyTractionTotalToQml(tractionSystemTotalEnergyCons);
    emit sendEnergyChargingTotalToQml(chargingTotalEnergy);
    emit sendEnergyRecuperationTotalToQml(recuperationTotalEnergy);

    emit sendEnergyAllConsumersDailyToQml(allConsumersDailyEnergyCons);
    emit sendEnergyTractionDailyToQml(tractionSystemDailyEnergyCons);
    emit sendEnergyChargingDailyToQml(chargingDailyEnergy);
    emit sendEnergyRecuperationDailyToQml(recuperationDailyEnergy);
}

void EnergyConsumption::dashboardLoadFinished(){

}
