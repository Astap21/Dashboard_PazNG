#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "additionaltask.h"
#include "can_bus.h"
#include "signal_lamp.h"
#include "DashBoardClasses/backlightcontrolclass.h"
#include "busComponentsClasses/brakesystem.h"
#include "busComponentsClasses/motor.h"
#include "busComponentsClasses/suspension.h"
#include "busComponentsClasses/exteriorlightning.h"
#include "busComponentsClasses/drivercabin.h"
#include "busComponentsClasses/businterior.h"
#include "busComponentsClasses/doorsPaz.h"
#include "busComponentsClasses/tachograph.h"
#include "busComponentsClasses/adas.h"
#include "DashBoardClasses/dashboardclass.h"
#include "DashBoardClasses/trans.h"
#include "DashBoardClasses/logtofile.h"
#include "DashBoardClasses/fpstext.h"
#include "DashBoardClasses/calculatemileage.h"

#include "canDataBase/canDataBase.h"
//#include <libudev.h>

#include "DashBoardClasses/gpio.h"
//#include "DashBoardClasses/fpstext.h"

int main(int argc, char *argv[])
{
    QString softVersion = "1.2.0";
    //Установка переменных среды
    //qputenv("QT_GSTREAMER_PLAYBIN_AUDIOSINK", "alsasink");
    //qputenv("QT_GSTREAMER_USE_PLAYBIN_VOLUME", "1");
    //qputenv("QT_QPA_EGLFS_FORCE888", "1");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //criticalThread.setPriority(QThread::TimeCriticalPriority);

    //LogToFile logtofile;
    qmlRegisterType<FPSText>("com.ast", 1, 0, "FPSText");
    qmlRegisterUncreatableType<SignalLampE>("com.gaz.signalLampE", 1, 0, "SignalLampE", "Enum only");

    Trans trans(&engine);
    // make this object available from QML side
    engine.rootContext()->setContextProperty("trans", &trans);

    qRegisterMetaType<QCanBusDevice::CanBusError>();
    CanBus ican("SCAN", "socketcan", "can0", 500000, &gCanDB, true, true);
    ican.addMessageToMissedMsgCheckList(gMessageName_EBC1);
    ican.addMessageToMissedMsgCheckList(gMessageName_ASC1);
    ican.addMessageToFastReceived(gMessageName_LD);
    engine.rootContext()->setContextProperty("ican", &ican);

    //QThread thread;
    //pwm.moveToThread(&thread);
    //pwm.playSound(0);
    //pwm.playSound(1);
    //pwm.playSound(2);

    DoorsPaz doors;
    engine.rootContext()->setContextProperty("doors", &doors);
    QObject::connect(&ican, &CanBus::sendCanDBUpdated, &doors, &DoorsPaz::canDBUpdated);

    Tachograph tachograph;
    engine.rootContext()->setContextProperty("tachograph", &tachograph);
    QObject::connect(&ican, &CanBus::sendCanDBUpdated, &doors, &Tachograph::canDBUpdated);

    Adas adas;
    engine.rootContext()->setContextProperty("adas", &adas);
    QObject::connect(&ican, &CanBus::sendCanDBUpdated, &doors, &Adas::canDBUpdated);

    BrakeSystem brakeSystem;
    engine.rootContext()->setContextProperty("brakeSystem", &brakeSystem);
    QObject::connect(&ican, &CanBus::sendCanDBUpdated, &brakeSystem, &BrakeSystem::canDBUpdated);

    Motor motor;
    engine.rootContext()->setContextProperty("motor", &motor);
    QObject::connect(&ican, &CanBus::sendCanDBUpdated, &motor, &Motor::canDBUpdated);

    Suspension suspension;
    engine.rootContext()->setContextProperty("suspension", &suspension);
    QObject::connect(&ican, &CanBus::sendCanDBUpdated, &suspension, &Suspension::canDBUpdated);

    ExteriorLightning exteriorLightning;
    engine.rootContext()->setContextProperty("exteriorLightning", &exteriorLightning);
    QObject::connect(&ican, &CanBus::sendCanDBUpdated, &exteriorLightning, &ExteriorLightning::canDBUpdated);
    //QObject::connect(&exteriorLightning, &ExteriorLightning::sendCanMsg, &canBus, &CanBus::sendCanMsgById);
    //exteriorLightning.moveToThread(&criticalThread);

    DriverCabin driverCabin;
    engine.rootContext()->setContextProperty("driverCabin", &driverCabin);
    QObject::connect(&ican, &CanBus::sendCanDBUpdated, &driverCabin, &DriverCabin::canDBUpdated);

    BusInterior busInterior;
    engine.rootContext()->setContextProperty("busInterior", &busInterior);
    QObject::connect(&ican, &CanBus::sendCanDBUpdated, &busInterior, &BusInterior::canDBUpdated);
    //    EnergyConsumption energyConsumption;
    //    engine.rootContext()->setContextProperty("energyConsumption", &energyConsumption);

    BacklightControlClass backlightControl("backlightControl");
    backlightControl.backlightLevelChanged(100);
    engine.rootContext()->setContextProperty("backlightControl", &backlightControl);

    Gpio KL_15(165, GPIO_INPUT);

    DashboardClass dashboardObject(softVersion, &KL_15, &backlightControl);
    engine.rootContext()->setContextProperty("dashboardObject", &dashboardObject);
    QObject::connect(&ican, &CanBus::writtenMsg_DB1, &dashboardObject, &DashboardClass::incHearthBeatCounter);

    InterfaceForConnectToQml interfaceForConnectToQml("interfaceForConnectToQml");
    engine.rootContext()->setContextProperty("connectionFromCpp", &interfaceForConnectToQml);

    softVersion = softVersion  + " - " + QString::number(GetGitCommitHash(),16);
    qDebug() << "softVersion " << softVersion;
    AdditionalTasks additionalTasks("additionalTasks", &interfaceForConnectToQml, softVersion);
    engine.rootContext()->setContextProperty("additionalTasks", &additionalTasks);

    CalculateMileage calculateMileage("calculateMileage");
    engine.rootContext()->setContextProperty("calculateMileage", &calculateMileage);

    QObject::connect(&brakeSystem, &BrakeSystem::sendMovementsBanState, &motor, &Motor::NeedMovementBanByBrakeSystem);
    QObject::connect(&doors, &Doors::sendMovementsBanState, &motor, &Motor::NeedMovementBanByDoor);

    // Register the .qrc file containing QML resources
    QResource::registerResource(":/images.qrc");

    //    qmlRegisterType<FPSText>("com.ast", 1, 0, "FPSText");


    const QUrl url(QStringLiteral("qrc:/loader.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
