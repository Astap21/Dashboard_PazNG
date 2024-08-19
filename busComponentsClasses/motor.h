#ifndef MOTOR_H
#define MOTOR_H

#include <QObject>
#include "busComponentsClasses/primarybuscomponent.h"

class Motor : public PrimaryBusComponent
{
    Q_OBJECT
public:
    explicit Motor(QObject *parent = nullptr);
    void SendStateToQml() override;
    void ReadStateFromCanDB() override;
    int getOilPressure();
    int getOilTemp();
    int getClTemp();
    int getTransmissionOilTemp();
    int getRetarderOilTemp();
    int getOutputShaftSpeed();
    int getFuelLevel();


public slots:
    void dashboardLoadFinished( )override;

private:
    QString previousComponentStateString = "P";
    QString actualGear = "P";

    struct {
        uint8_t off = 0;
        uint8_t yellowLamp = 1;
        uint8_t redLamp = 2;
        uint8_t greenLamp = 3;
        uint8_t redLampFlashing = 4;
        uint8_t greenLampFlashing_2Hz = 5;
        uint8_t greenLampOn_5s = 6;
    } lamp;

    uint tractionMotorError = 0;
    uint tractionMotorOverheat = 0;
    uint lowLiquidLevelMotorSystem = 0;
    uint circulationPump = 0;
    uint readyToMove = 0;
    uint lowPower = 0;

    uint batteryStatus = 0;
    uint chargingStatus = 0;

    float vehicleSpeed = 0;
    float hvCurrent = 0;
    float hvVoltage = 0;
    float hvSoc = 0;
    int engineTemp = 0;
    uint estimatedRange = 0;
    uint tmsError = 0;
    uint tmsOn = 0;
    uint motorStatus = 0;
    uint steeringWheel = 0;
    uint batteryHeating = 0;
    uint isolation = 0;
    uint pant = 0;
    uint contactor = 0;

signals:
    void sendActualGearToQml(const QString& inputString);
    //ELECTRO
    void sendHvCurrentToQml(const float& inputFloat);
    void sendHvVoltageToQml(const float& inputFloat);
    void sendHvSocToQml(const float& inputFloat);
    void sendBatteryStatusToQml(const uint& inputUint);
    //CECU_0
    void sendEstimatedRangeToQml(const uint& inputUint);
    //CCVS1
    void sendSpeedToQml(const float& inputFloat);
    //
    void sendOverheatMotorToQml(const uint& inputUint);
    void sendEngineLampToQml(const uint& inputUint);
    void sendEngineLowCoolantLevelToQml(const uint& inputUint);
    void sendReadyToMoveToQml(const uint& inputUint);
    void sendLowPowerToQml(const uint& inputUint);

    void sendEngineTempToQml(const float& inputFloat);
    void sendCirculationPumpToQml(const uint& inputUint);

    void send_tmsErrorToQml(const uint& inputUint);
    void send_tmsOnToQml(const uint& inputUint);
    void send_motorStatusToQml(const uint& inputUint);
    void send_steeringWheelToQml(const uint& inputUint);
    void send_batteryHeatingToQml(const uint& inputUint);
    void send_externalCordToQml(const uint& inputUint);
    void send_isolationToQml(const uint& inputUint);
    void send_pantToQml(const uint& inputUint);
    void send_contactorToQml(const uint& inputUint);

};

#endif // MOTOR_H
