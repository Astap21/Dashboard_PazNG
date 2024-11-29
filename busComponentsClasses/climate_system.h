#ifndef CLIMATE_SYSTEM_H
#define CLIMATE_SYSTEM_H

#include <QObject>
#include "busComponentsClasses/primarybuscomponent.h"

class climate_system : public PrimaryBusComponent
{
    Q_OBJECT
    Q_PROPERTY(int EngineTemp READ getEngineTemp NOTIFY sendEngineTemp)
    Q_PROPERTY(int MeasuredTemp1 READ getMeasuredTemp1 NOTIFY sendMeasuredTemp1)
    Q_PROPERTY(int MeasuredTemp2 READ getMeasuredTemp2 NOTIFY sendMeasuredTemp2)
    Q_PROPERTY(int MeasuredTemp3 READ getMeasuredTemp3 NOTIFY sendMeasuredTemp3)
    Q_PROPERTY(int InletWaterTemp READ getInletWaterTemp NOTIFY sendInletWaterTemp)
    Q_PROPERTY(int OutletWaterTemp READ getOutletWaterTemp NOTIFY sendOutletWaterTemp)
    Q_PROPERTY(int FaultCodeTMS READ getFaultCodeTMS NOTIFY sendFaultCodeTMS)
    Q_PROPERTY(float HighestCellTemp READ getHighestCellTemp NOTIFY sendHighestCellTemp)
    Q_PROPERTY(float LowestCellTemp READ getLowestCellTemp NOTIFY sendLowestCellTemp)
    Q_PROPERTY(float AverageCellTemp READ getAverageCellTemp NOTIFY sendAverageCellTemp)
    Q_PROPERTY(int ElectronicsTemp READ getElectronicsTemp NOTIFY sendElectronicsTemp)
public:
    climate_system();
    void ReadStateFromCanDB()override;
    void dashboardLoadFinished() override;
private:
    int EngineTemp = 0;
    int MeasuredTemp1 = 0;
    int MeasuredTemp2 = 0;
    int MeasuredTemp3 = 0;
    int InletWaterTemp = 0;
    int OutletWaterTemp = 0;
    int FaultCodeTMS = 0;
    float HighestCellTemp = 0;
    float LowestCellTemp = 0;
    float AverageCellTemp = 0;
    int ElectronicsTemp = 0;
    int getEngineTemp(void);
    int getMeasuredTemp1(void);
    int getMeasuredTemp2(void);
    int getMeasuredTemp3(void);
    int getInletWaterTemp(void);
    int getOutletWaterTemp(void);
    int getFaultCodeTMS(void);
    float getHighestCellTemp(void);
    float getLowestCellTemp(void);
    float getAverageCellTemp(void);
    int getElectronicsTemp(void);
signals:
    void sendEngineTemp(const int& inputInt);
    void sendMeasuredTemp1(const int& inputInt);
    void sendMeasuredTemp2(const int& inputInt);
    void sendMeasuredTemp3(const int& inputInt);
    void sendInletWaterTemp(const int& inputInt);
    void sendOutletWaterTemp(const int& inputInt);
    void sendFaultCodeTMS(const int& inputInt);
    void sendHighestCellTemp(const float& inputFloat);
    void sendLowestCellTemp(const float& inputFloat);
    void sendAverageCellTemp(const float& inputFloat);
    void sendElectronicsTemp(const int& inputInt);
};

#endif // CLIMATE_SYSTEM_H
