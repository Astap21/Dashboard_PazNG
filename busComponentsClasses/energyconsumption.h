#ifndef ENERGYCONSUMPTION_H
#define ENERGYCONSUMPTION_H

#include <QObject>
#include "busComponentsClasses/primarybuscomponent.h"

class EnergyConsumption : public PrimaryBusComponent
{
    Q_OBJECT
    Q_PROPERTY(float EnergyForTractionTotal READ getEnergyForTractionTotal NOTIFY sendEnergyForTractionTotal)
    Q_PROPERTY(float EnergyForTractionDaily READ getEnergyForTractionDaily NOTIFY sendEnergyForTractionDaily)
    Q_PROPERTY(float EnergyWithRecuperationTotal READ getEnergyWithRecuperationTotal  NOTIFY sendEnergyWithRecuperationTotal)
    Q_PROPERTY(float EnergyWithRecuperationDaily READ getEnergyWithRecuperationDaily  NOTIFY sendEnergyWithRecuperationDaily)
    Q_PROPERTY(float EnergyRecuperationTotal READ getEnergyRecuperationTotal  NOTIFY sendEnergyRecuperationTotal)
    Q_PROPERTY(float EnergyRecuperationDaily READ getEnergyRecuperationDaily  NOTIFY sendEnergyRecuperationDaily)
    Q_PROPERTY(float RatioRecupToEnergyTotal READ getRatioRecupToEnergyTotal   NOTIFY sendRatioRecupToEnergyTotal)
    Q_PROPERTY(float RatioRecupToEnergyDaily READ getRatioRecupToEnergyDaily  NOTIFY sendRatioRecupToEnergyDaily)

public:
    explicit EnergyConsumption(QObject *parent = nullptr);
    void ReadStateFromCanDB() override;
public slots:
    void dashboardLoadFinished() override;
private:
//    float climatSystemTotalEnergyCons;
//    float climatSystemDailyEnergyCons;
//    float allConsumersTotalEnergyCons;
//    float allConsumersDailyEnergyCons;
//    float tractionSystemTotalEnergyCons;
//    float tractionSystemDailyEnergyCons;
//    float chargingTotalEnergy;
//    float chargingDailyEnergy;
//    float recuperationTotalEnergy;
//    float recuperationDailyEnergy;

    float EnergyForTractionTotal  = 0;
    float EnergyForTractionDaily  = 0;
    float EnergyWithRecuperationTotal = 0;
    float EnergyWithRecuperationDaily = 0;
    float EnergyRecuperationTotal = 0;
    float EnergyRecuperationDaily = 0;
    float RatioRecupToEnergyTotal = 0;
    float RatioRecupToEnergyDaily = 0;

    float getEnergyForTractionTotal (void);
    float getEnergyForTractionDaily (void);
    float getEnergyWithRecuperationTotal (void);
    float getEnergyWithRecuperationDaily (void);
    float getEnergyRecuperationTotal (void);
    float getEnergyRecuperationDaily (void);
    float getRatioRecupToEnergyTotal (void);
    float getRatioRecupToEnergyDaily (void);

signals:
//    void sendEnergyClimatTotalToQml(const float& inputFloat);
//    void sendEnergyClimatDailyToQml(const float& inputFloat);

//    void sendEnergyAllConsumersTotalToQml(const float& inputFloat);
//    void sendEnergyTractionTotalToQml(const float& inputFloat);
//    void sendEnergyChargingTotalToQml(const float& inputFloat);
//    void sendEnergyRecuperationTotalToQml(const float& inputFloat);

//    void sendEnergyAllConsumersDailyToQml(const float& inputFloat);
//    void sendEnergyTractionDailyToQml(const float& inputFloat);
//    void sendEnergyChargingDailyToQml(const float& inputFloat);
//    void sendEnergyRecuperationDailyToQml(const float& inputFloat);

    void sendEnergyForTractionTotal(const float& inputFloat);
    void sendEnergyForTractionDaily(const float& inputFloat);
    void sendEnergyWithRecuperationTotal(const float& inputFloat);
    void sendEnergyWithRecuperationDaily(const float& inputFloat);
    void sendEnergyRecuperationTotal(const float& inputFloat);
    void sendEnergyRecuperationDaily(const float& inputFloat);
    void sendRatioRecupToEnergyTotal(const float& inputFloat);
    void sendRatioRecupToEnergyDaily(const float& inputFloat);

};

#endif // ENERGYCONSUMPTION_H
