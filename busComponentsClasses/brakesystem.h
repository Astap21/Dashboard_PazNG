#ifndef BRAKESYSTEM_H
#define BRAKESYSTEM_H

#include <QObject>
#include <QVector>
#include "busComponentsClasses/tire.h"
#include "busComponentsClasses/primarybuscomponent.h"

class BrakeSystem : public PrimaryBusComponent
{
    Q_OBJECT
    Q_PROPERTY(float lowTirePressure READ getLowTirePressure CONSTANT)
    Q_PROPERTY(float highTirePressure READ getHighTirePressure CONSTANT)
    Q_PROPERTY(float highTireTemp READ getHighTireTemp CONSTANT)
    Q_PROPERTY(float lowBrakePads_Percent READ getLowBrakePads_Percent CONSTANT)
public:
    explicit BrakeSystem(QObject *parent = nullptr);
    float getLowTirePressure();
    float getHighTirePressure();
    float getHighTireTemp();
    float getLowBrakePads_Percent();
    void SendStateToQml() override;
    void ReadStateFromCanDB() override;
public slots:
    void dashboardLoadFinished() override;
    void menuLoadFinished();
private:
    Tire *tire_00;
    Tire *tire_01;
    Tire *tire_11;
    Tire *tire_10;
    Tire *tire_12;
    Tire *tire_13;
    QVector<Tire*> tires;

    float lowTirePressure = 8.4;
    float highTirePressure = 9.5;
    float highTireTemp = 60;

    float pressureCircuit1_bar;
    float pressureCircuit2_bar;
    bool pressureCircuit1_Indication;
    bool pressureCircuit2_Indication;
    bool pressureCircuit3_Indication;
    bool pressureCircuit4_Indication;
    uint pressureCircuitSuspension_Indication;
    float brakePedalPosition;
    float retarderPercent = 0;
    uint reqStopSound = 0;
    uint compressorState = 0;

    float lowBrakePads_Percent = 25;
    float  frontLeftBrakePads_Percent;
    float  frontRightBrakePads_Percent;
    float  rearLeftBrakePads_Percent;
    float  rearRightBrakePads_Percent;

    uint EBS_Indication = 0;
    struct {
        uint8_t off = 0;
        uint8_t yellowLamp = 1;
        uint8_t redLamp = 2;
        uint8_t redLampFlashing = 3;
    } EBS_Lamp;
    uint ASR_Indication = 0;
    struct {
        uint8_t off = 0;
        uint8_t lampASR_On = 1;
        uint8_t lampASR_Off = 2;
        uint8_t toggleLampASR_On = 3;
    } ASR_Lamp;
    uint ESC_Indication = 0;
    struct {
        uint8_t off = 0;
        uint8_t toggleLampESC_On = 1;
        uint8_t lampESC_On = 2;
        uint8_t lampESC_Off = 3;
        uint8_t toggleLampESC_Off = 4;
    } ESC_Lamp;
    uint HillHolder_Indication = 0;
    struct {
        uint8_t off = 0;
        uint8_t LampHH_On = 1;
        uint8_t toggleLampHH_On = 2;
        uint8_t toggleFastLampHH_On = 3;
    } HillHolderLamp;
    struct {
        uint8_t off = 0;
        uint8_t tractionControl_On = 1;
        uint8_t tractionControl_Off = 2;
    } TractionControlLamp;
    uint TractionControl= 0;

    uint HaltBrake_Indication = 0;
    float pressureParkingBrake_bar = 0;
    uint parkingBrake_Indication = 0;
    struct {
        uint8_t off = 0;
        uint8_t on = 1;
        uint8_t flashing = 2;
    } parkingBrake_Lamp;
    bool minBrakePadsIndication;
    bool tireIndication;
    uint movementsBan;
signals:
    void sendMovementsBanState(const uint& inputUint);
    //TIRE
    void sendPressureFrontLeftTireToQml(const float& inputFloat);
    void sendTempFrontLeftTireToQml(const float& inputFloat);
    void sendPressureRearLeftTire1ToQml(const float& inputFloat);
    void sendTempRearLeftTire1ToQml(const float& inputFloat);
    void sendPressureRearLeftTire2ToQml(const float& inputFloat);
    void sendTempRearLeftTire2ToQml(const float& inputFloat);
    void sendPressureFrontRightTireToQml(const float& inputFloat);
    void sendTempFrontRightTireToQml(const float& inputFloat);
    void sendPressureRearRightTire1ToQml(const float& inputFloat);
    void sendTempRearRightTire1ToQml(const float& inputFloat);
    void sendPressureRearRightTire2ToQml(const float& inputFloat);
    void sendTempRearRightTire2ToQml(const float& inputFloat);

    //AIR1
    void sendPressureCircuit1ToQml(const float& inputFloat);
    void sendPressureCircuit2ToQml(const float& inputFloat);
    void sendPressureCircuit1LampToQml(const bool& inputBool);
    void sendPressureCircuit2LampToQml(const bool& inputBool);
    void sendPressureCircuit3LampToQml(const bool& inputBool);
    void sendPressureCircuit4LampToQml(const bool& inputBool);
    void sendLowPressureSuspensionToQml(const uint& inputUint);
    void sendCompressorStateToQml(const uint& inputUint);


    void sendPressureCircuitParkBrakeToQml(const uint& inputUint);
    //EBC1
    void sendEBS_IndicationToQml(const uint& inputUint);
    void sendASR_IndicationToQml(const uint& inputUint);
    void sendESC_IndicationToQml(const uint& inputUint);
    void sendHillHolderIndicationToQml(const uint& inputUint);
    void sendHaltBrakeStatusToQml(const bool& inputBool);
    void sendBrakePedalPositionStatusToQml(const float& inputFloat);
    //TIRE
    void sendLowTirePressureToQml(const bool& inputBool);
    //EBC4
    void sendLowBrakePadsToQml(const bool& inputBool);
    //EBC4
    void sendFrontLeftBrakePercentToQml(const float& inputFloat);
    void sendFrontRightBrakePercentToQml(const float& inputFloat);
    void sendRearLeftBrakePercentToQml(const float& inputFloat);
    void sendRearRightBrakePercentToQml(const float& inputFloat);
    //ERC1
    void sendRetarderPercentToQml(const float& inputFloat);
    void sendReqStopSoundToQml(const uint& inputUint);
    void sendTractionControlToQml(const uint& inputUint);
};

#endif // BRAKESYSTEM_H
