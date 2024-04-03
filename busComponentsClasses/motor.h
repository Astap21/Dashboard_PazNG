#ifndef MOTOR_H
#define MOTOR_H

#include <QObject>
#include "busComponentsClasses/primarybuscomponent.h"

class Motor : public PrimaryBusComponent
{
    Q_OBJECT
    Q_PROPERTY(int oilPressure READ getOilPressure NOTIFY sendOilPressureToQml)
    Q_PROPERTY(int oilTemp READ getOilTemp NOTIFY sendOilTempToQml)
    Q_PROPERTY(int clTemp READ getClTemp NOTIFY sendClTempToQml)

    Q_PROPERTY(int transmissionOilTemp READ getTransmissionOilTemp NOTIFY sendTransmissionOilTempToQml)
    Q_PROPERTY(int retarderOilTemp READ getRetarderOilTemp NOTIFY sendRetarderOilTempToQml)
    Q_PROPERTY(int outputShaftSpeed READ getOutputShaftSpeed NOTIFY sendOutputShaftSpeedToQml)

    Q_PROPERTY(int fuelLevel READ getFuelLevel NOTIFY sendFuelLevelToQml)
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
    uint waterInFuel;
    uint circulationPump;
    uint airFilterDirty;
    uint lowOilPressure;
    uint heatingInsideAir;
    uint lowUrea;
    uint exhaustError;
    uint autoTransOverheating;
    uint autoTransError;
    float vehicleSpeed;
    float engineSpeed;
    int engineTemp;

    int oilPressure;
    int oilTemp;
    int clTemp;
    int transmissionOilTemp;
    int retarderOilTemp;
    int outputShaftSpeed;
    int fuelLevel;

signals:
    void sendActualGearToQml(const QString& inputString);
    //EEC1
    void sendEngineSpeedToQml(const float& inputFloat);
    //CCVS1
    void sendSpeedToQml(const float& inputFloat);
    //DLCC1
    void sendOverheatMotorToQml(const bool& inputBool);
    void sendEngineLampToQml(const uint& inputUint);
    void sendEngineLowCoolantLevelToQml(const bool& inputBool);


    void sendEngineTempToQml(const float& inputFloat);

    void sendWaterInFuelToQml(const uint& inputUint);
    void sendCirculationPumpToQml(const uint& inputUint);
    void sendAirFilterDirtyToQml(const uint& inputUint);
    void sendLowOilPressureToQml(const uint& inputUint);
    void sendHeatingInsideAirToQml(const uint& inputUint);
    void sendLowUreaToQml(const uint& inputUint);
    void sendExhaustErrorToQml(const uint& inputUint);
    void sendAutoTransOverheatingToQml(const uint& inputUint);
    void sendAutoTransErrorToQml(const uint& inputUint);

    void sendClTempToQml(const int& inputInt);
    void sendOilTempToQml(const int& inputInt);
    void sendOilPressureToQml(const int& inputInt);

    void sendTransmissionOilTempToQml(const int& inputInt);
    void sendRetarderOilTempToQml(const int& inputInt);
    void sendOutputShaftSpeedToQml(const int& inputInt);
    void sendFuelLevelToQml(const int& inputInt);
};

#endif // MOTOR_H
