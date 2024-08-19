#ifndef BUSINTERIOR_H
#define BUSINTERIOR_H

#include <QObject>
#include "busComponentsClasses/primarybuscomponent.h"

class BusInterior : public PrimaryBusComponent
{
    Q_OBJECT
public:
    explicit BusInterior(QObject *parent = nullptr);
    void SendStateToQml() override;
    void ReadStateFromCanDB()override;
public slots:
    void dashboardLoadFinished() override;

private:
    uint interiorLightning = 0;
    uint hammerLamp = 0;
    uint fireExtingusherLamp = 0;
    uint liquidHeater = 0;
    uint fuelLevelLamp = 0;
    uint rampStatus = 0;
    uint requestDisablePerson = 0;
    uint rearCompartment = 0;
    uint frontCompartment = 0;
    uint rampError = 0;
    uint doorValve = 0;
    uint error24v = 0;
    float FuelLevel = 0;
    float BatteryVoltage24v = 0;
    float insideTempF = 0;
    float outsideTempF = 0;
    float salonTempF = 0;
    QString insideTempS = "--";
    QString outsideTempS = "--";
    QString salonTempS = "--";
    QString convertFloatToStrForTemp(double inputNumber);

signals:
    void sendInteriorLightingToQml(const uint& inputUint);
    void sendHammerStatusToQml(const uint& inputUint);
    void sendFireExtingStatusToQml(const uint& inputUint);
    void sendLiquidHeaterToQml(const uint& inputUint);
    void sendFuelLevelLampToQml(const uint& inputUint);
    void sendRampStatusToQml(const uint& inputUint);
    void sendRequestDisablePersonToQml(const uint& inputUint);
    void sendRearCompartmentStatusToQml(const uint& inputUint);
    void sendFrontCompartmentStatusToQml(const uint& inputUint);
    void sendFuelLevelToQml(const float& inputFloat);
    void sendBattery24VoltageToQml(const float& inputFloat);
    void sendError24VToQml(const uint& inputUint);
    void sendTempOutsideToQml(const QString& inputString);
    void sendTempInsideToQml(const QString& inputString);
    void sendTempSalonToQml(const QString& inputString);
    void sendRampErrorToQml(const uint& inputUint);
    void sendDoorValveToQml(const uint& inputUint);

};

#endif // BUSINTERIOR_H
