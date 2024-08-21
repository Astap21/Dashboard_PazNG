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
    uint returnValveStatus(const int& doorNumber) override;
};

#endif // DOORSPAZ_H
