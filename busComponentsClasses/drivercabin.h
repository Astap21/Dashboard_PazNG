#ifndef DRIVERCABIN_H
#define DRIVERCABIN_H

#include <QObject>
#include "busComponentsClasses/primarybuscomponent.h"

class DriverCabin : public PrimaryBusComponent
{
    Q_OBJECT
    Q_PROPERTY(uint wipersWorkCounter READ GetWipersWorkCounter WRITE SetWipersWorkCounter NOTIFY sendWipersWorkCounter)
    Q_PROPERTY(float washerFluidLevel READ GetWasherFluidLevel NOTIFY sendWasherFluidLevelToQml)
public:
    explicit DriverCabin(QObject *parent = nullptr);
    void SendStateToQml() override;
    void ReadStateFromCanDB() override;
    uint GetWipersWorkCounter();
    void SetWipersWorkCounter(const uint& inputUint);
public slots:
    void dashboardLoadFinished() override;

private:
    uint wipersWorkCounter = 101;

    uint ElecticHeatedWindshield = 0;
    uint ElecticHeatedSideWindows = 0;
    uint WasherFluidLamp = 0;
    uint WipersAutoStatus = 0;
    uint HeaterMirrorsStatus = 0;
    uint WipersStatus = 0;
    uint SeatBelt = 0;
    uint NoDriver = 0;
    uint SeatHeating = 0;
    float washerFluidLevel = 0;
    uint routeIndicator = 0;
    uint heatedSteering = 0;
    uint buttonsOnWheel = 0;
    struct {
        uint8_t LampOff = 0;
        uint8_t LampOnSpeed1 = 1;
        uint8_t LampOnSpeed2 = 2;
        uint8_t LampOnIntermittentMode = 3;
    } wipersStatusLamp;
    float GetWasherFluidLevel(void);
signals:
    void sendWindshieldHeatingStatusToQml(const uint& inputUint);
    void sendElecticHeatedSideWindowsStatusToQml(const uint& inputUint);
    void sendSeatHeatingStatusToQml(const uint& inputUint);
    void sendWasherFluidLampToQml(const uint& inputUint);
    void sendWipersStatusToQml(const uint& inputUint);
    void sendWipersAutoStatusToQml(const uint& inputUint);
    void sendHeaterMirrorsStatusToQml(const uint& inputUint);
    void sendWasherFluidLevelToQml(const float& inputFloat);
    void sendOperatorSeatDirectionSwitchToQml(const uint& inputUint);
    void sendSeatBeltSwitchToQml(const uint& inputUint);
    void sendWipersWorkCounter(const uint& inputUint);
    void sendRouteIndicatorToQml(const uint& inputUint);
    void sendHeatedSteeringToQml(const uint& inputUint);
    void sendButtonsOnWheelToQml(const uint& inputUint);
};

#endif // DRIVERCABIN_H
