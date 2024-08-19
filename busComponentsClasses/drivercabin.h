﻿#ifndef DRIVERCABIN_H
#define DRIVERCABIN_H

#include <QObject>
#include "busComponentsClasses/primarybuscomponent.h"

class DriverCabin : public PrimaryBusComponent
{
    Q_OBJECT
    Q_PROPERTY(uint wipersWorkCounter READ GetWipersWorkCounter WRITE SetWipersWorkCounter NOTIFY sendWipersWorkCounter)
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
    float WasherFluidLevel = 0;
    struct {
        uint8_t LampOff = 0;
        uint8_t LampOnSpeed1 = 1;
        uint8_t LampOnSpeed2 = 2;
        uint8_t LampOnIntermittentMode = 3;
    } wipersStatusLamp;

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
};

#endif // DRIVERCABIN_H
