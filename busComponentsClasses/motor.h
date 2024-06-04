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

    uint tractionMotorError;
    uint tractionMotorOverheat;
    uint lowLiquidLevelMotorSystem;
    uint circulationPump;

    uint batteryStatus;

    float vehicleSpeed;
    float hvCurrent;
    float hvVoltage;
    float hvSoc;
    int engineTemp;
    uint estimatedRange;

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
    void sendOverheatMotorToQml(const bool& inputBool);
    void sendEngineLampToQml(const uint& inputUint);
    void sendEngineLowCoolantLevelToQml(const bool& inputBool);


    void sendEngineTempToQml(const float& inputFloat);
    void sendCirculationPumpToQml(const uint& inputUint);

};

#endif // MOTOR_H
