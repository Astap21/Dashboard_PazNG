QT += quick
CONFIG += c++14

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

INCLUDEPATH += DashboardGeneral

SOURCES += \
    DashboardGeneral/DashBoardClasses/backlightcontrolclass.cpp \
    DashboardGeneral/DashBoardClasses/button.cpp \
    DashboardGeneral/DashBoardClasses/copylinyxlogmessage.cpp \
    DashboardGeneral/DashBoardClasses/dashboardclass.cpp \
    DashboardGeneral/DashBoardClasses/fpstext.cpp \
    DashboardGeneral/DashBoardClasses/gpio.cpp \
    DashboardGeneral/DashBoardClasses/logtofile.cpp \
    DashboardGeneral/DashBoardClasses/menuclass.cpp \
    DashboardGeneral/DashBoardClasses/pwm.cpp \
    DashboardGeneral/DashBoardClasses/trans.cpp \
    DashboardGeneral/additionaltask.cpp \
    DashboardGeneral/busComponentsClasses/doors.cpp \
    DashboardGeneral/busComponentsClasses/exteriorlightning.cpp \
    DashboardGeneral/busComponentsClasses/primarybuscomponent.cpp \
    DashboardGeneral/busComponentsClasses/tire.cpp \
    DashboardGeneral/canDataBase/canDataClass.cpp \
    DashboardGeneral/canDataBase/canMessageClass.cpp \
    DashboardGeneral/canDataBase/canSignalClass.cpp \
    DashboardGeneral/can_bus.cpp \
    DashboardGeneral/qml_interface.cpp \     
    busComponentsClasses/brakesystem.cpp \
    busComponentsClasses/businterior.cpp \
    busComponentsClasses/drivercabin.cpp \
    busComponentsClasses/energyconsumption.cpp \
    busComponentsClasses/motor.cpp \
    busComponentsClasses/suspension.cpp \
    canDataBase/canDataBase.cpp \
    loader.cpp \

RESOURCES += qml.qrc \
    images.qrc

#QT_DEBUG_PLUGINS = $${1}

# To link the wiringPi library when making the executable
#LIBS += -L/usr/local/include -lwiringPi

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

INSTALLS        = target
target.path     = /home/root

HEADERS += \
    DashboardGeneral/DashBoardClasses/backlightcontrolclass.h \
    DashboardGeneral/DashBoardClasses/button.h \
    DashboardGeneral/DashBoardClasses/copylinyxlogmessage.h \
    DashboardGeneral/DashBoardClasses/dashboardclass.h \
    DashboardGeneral/DashBoardClasses/fpstext.h \
    DashboardGeneral/DashBoardClasses/gpio.h \
    DashboardGeneral/DashBoardClasses/logtofile.h \
    DashboardGeneral/DashBoardClasses/menuclass.h \
    DashboardGeneral/DashBoardClasses/pwm.h \
    DashboardGeneral/DashBoardClasses/trans.h \
    DashboardGeneral/additionaltask.h \
    DashboardGeneral/busComponentsClasses/doors.h \
    DashboardGeneral/busComponentsClasses/exteriorlightning.h \
    DashboardGeneral/busComponentsClasses/primarybuscomponent.h \
    DashboardGeneral/busComponentsClasses/tire.h \
    DashboardGeneral/canDataBase/canDB_Libs.h \
    DashboardGeneral/canDataBase/canDataClass.h \
    DashboardGeneral/canDataBase/canMessageClass.h \
    DashboardGeneral/canDataBase/canSignalClass.h \
    DashboardGeneral/can_bus.h \
    DashboardGeneral/qml_interface.h \
    busComponentsClasses/brakesystem.h \
    busComponentsClasses/businterior.h \
    busComponentsClasses/drivercabin.h \
    busComponentsClasses/energyconsumption.h \
    busComponentsClasses/motor.h \
    busComponentsClasses/suspension.h \
    canDataBase/canDataBase.h \

QT += serialbus
QT += multimedia
QT += charts

QMAKE_TARGET_COPYRIGHT = (c) My Company Name
#INCLUDEPATH += $$PWD/images

#DEFINES ''= QMLJSDEBUGGER
#DEFINES''= QT_DECLARATIVE_DEBUG
#CONFIG += declarative_debug


# файлы перевода
TRANSLATIONS += translate/dbPazElectro_en.ts \
                translate/dbPazElectro_de.ts

lupdate_only { # that way those files will be skipped by C++ compiler
    SOURCES = *.qml # \
              # pages/*.qml
}

DISTFILES += \
    DashboardGeneral/images/signalLamps/battery/batHvOn.png \
    DashboardGeneral/images/signalLamps/battery/batHvWarning.png
