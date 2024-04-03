#ifndef ENERGYCONSUMPTION_H
#define ENERGYCONSUMPTION_H

#include <QObject>
#include "busComponentsClasses/primarybuscomponent.h"

class EnergyConsumption : public PrimaryBusComponent
{
    Q_OBJECT
public:
    explicit EnergyConsumption(QObject *parent = nullptr);
    void SendStateToQml() override;
    void ReadStateFromCanDB() override;
public slots:
    void dashboardLoadFinished() override;

private:
    float climatSystemTotalEnergyCons;
    float climatSystemDailyEnergyCons;
    float allConsumersTotalEnergyCons;
    float allConsumersDailyEnergyCons;
    float tractionSystemTotalEnergyCons;
    float tractionSystemDailyEnergyCons;
    float chargingTotalEnergy;
    float chargingDailyEnergy;
    float recuperationTotalEnergy;
    float recuperationDailyEnergy;

signals:
    void sendEnergyClimatTotalToQml(const float& inputFloat);
    void sendEnergyClimatDailyToQml(const float& inputFloat);

    void sendEnergyAllConsumersTotalToQml(const float& inputFloat);
    void sendEnergyTractionTotalToQml(const float& inputFloat);
    void sendEnergyChargingTotalToQml(const float& inputFloat);
    void sendEnergyRecuperationTotalToQml(const float& inputFloat);

    void sendEnergyAllConsumersDailyToQml(const float& inputFloat);
    void sendEnergyTractionDailyToQml(const float& inputFloat);
    void sendEnergyChargingDailyToQml(const float& inputFloat);
    void sendEnergyRecuperationDailyToQml(const float& inputFloat);

};

#endif // ENERGYCONSUMPTION_H
