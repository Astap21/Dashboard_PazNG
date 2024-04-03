#ifndef SUSPENSION_H
#define SUSPENSION_H

#include <QObject>
#include "busComponentsClasses/primarybuscomponent.h"

class Suspension : public PrimaryBusComponent
{
    Q_OBJECT
public:
    explicit Suspension(QObject *parent = nullptr);
    void SendStateToQml() override;
    void ReadStateFromCanDB() override;
public slots:
    void dashboardLoadFinished() override;

private:
    void SuspensionLampControl();
    enum SuspensionStateLamp
    {
        LampOff = 0,
        LampNotNormal = 1,
        LampUpperLevel = 2,
        LampUpperLevelToggle = 3,
        LampLowerLevel = 4,
        LampLowerLevelToggle = 5,
    }SuspensionState;

    uint SuspensionError = 0;
    struct{
        uint8_t LampOff = 0;
        uint8_t LampYellow = 1;
        uint8_t LampRed = 2;
    }SuspensionErrorLamp;

    uint kneelingStatus = 0;
    struct {
        uint8_t LampOff = 0;
        uint8_t LampOn = 1;
        uint8_t LampToggle = 2;
        uint8_t LampAuto = 3;
    }kneelingStatusLamp;

signals:
    //ASC1_A
    void sendSuspensionErrorToQml(const uint& inputUint);
    void sendSuspensionStatusToQml(const uint& inputUint);
    void sendKneelingStatusToQml(const uint& inputUint);
    void sendAutoKneelingStatusToQml(const bool& inputBool);

};

#endif // SUSPENSION_H
