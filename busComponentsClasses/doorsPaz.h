#ifndef DOORSPAZ_H
#define DOORSPAZ_H

#include <QObject>
#include <QMap>
#include "DashboardGeneral/busComponentsClasses/doors.h"

class DoorsPaz : public Doors
{
    Q_OBJECT

public:
    explicit DoorsPaz(QObject *parent = nullptr);
    uint returnDoorStatus(const int& doorNumber) override;
    valve_state_e GetValveStatus(const int &doorNumber, const valve_side_e &side) override;
    uint GetRampState() override;
};

#endif // DOORSPAZ_H
