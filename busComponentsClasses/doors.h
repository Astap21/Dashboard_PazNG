#ifndef DOORS_H
#define DOORS_H

#include <QObject>
#include <QMap>
#include "DashboardGeneral/busComponentsClasses/primarybuscomponent.h"

class Doors : public PrimaryBusComponent
{
    Q_OBJECT
    Q_PROPERTY(bool passControlDoor1 READ getPassControlDoor1 WRITE setPassControlDoor1)
    Q_PROPERTY(bool passControlDoor2 READ getPassControlDoor2 WRITE setPassControlDoor2)
    Q_PROPERTY(bool autoClosing READ getAutoClosing WRITE setAutoClosing)
    Q_PROPERTY(uint autoClosingTime READ getAutoClosingTime WRITE setAutoClosingTime NOTIFY sendAutoClosingTime)
    Q_PROPERTY(bool autoOpening READ getAutoOpening WRITE setAutoOpening)
    Q_PROPERTY(bool stepLightning READ getStepLightning WRITE setStepLightning)
    Q_PROPERTY(uint stepLightningDistance READ getStepLightningDistance WRITE setStepLightningDistance  NOTIFY sendStepLightningDistance)
    Q_PROPERTY(bool passSensor READ getPassSensor WRITE setPassSensor)
public:
    explicit Doors(QObject *parent = nullptr);
    uint GetDoorState(const int& doorNumber);
    uint GetValvesState(const int& doorNumber);
    void SendStateToQml() override;
    void ReadStateFromCanDB() override;
    bool getPassControlDoor1();
    bool getPassControlDoor2();
    bool getAutoClosing ();
    uint getAutoClosingTime();
    bool getAutoOpening();
    bool getStepLightning();
    uint getStepLightningDistance();
    bool getPassSensor();

public slots:
    void dashboardLoadFinished() override;
    void setPassControlDoor1(const bool& state);
    void setPassControlDoor2(const bool& state);
    void setAutoClosing(const bool& state);
    void setAutoClosingTime(const uint& inputUint);
    void setAutoOpening(const bool& state);
    void setStepLightning (const bool& state);
    void setStepLightningDistance(const uint& inputUint);
    void setPassSensor(const bool& state);
private:
    bool passControlDoor1;
    bool passControlDoor2;
    bool autoClosing;
    uint autoClosingTime;
    bool autoOpening;
    bool stepLightning;
    uint stepLightningDistance;
    bool passSensor;

    uint door1State;
    uint door2State;
    uint returnDoorStatus(const int& doorNumber);
    QMap<QString, uint> valvesMap;
    bool leastOneCapIsOpen = false;
    bool leastOneValveIsOpen = false;
    uint returnValveStatus(const int& doorNumber);
signals:
    void sendDoor1StatusToQml(uint doorStatus);
    void sendDoor2StatusToQml(uint doorStatus);
    void sendValveIn1StatusToQml(const uint& inputUint);
    void sendValveIn2StatusToQml(const uint& inputUint);
    void sendValveOut1StatusToQml(const uint& inputUint);
    void sendValveOut2StatusToQml(const uint& inputUint);

    void sendLeastOneCapIsOpenToQml(const uint& inputUint);
    void sendLeastOneValveIsOpenToQml(const uint& inputUint);

    void sendAutoClosingTime();
    void sendStepLightningDistance();
};

#endif // DOORS_H
