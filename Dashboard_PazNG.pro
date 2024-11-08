QT += quick
CONFIG += c++14

QMAKE_CXXFLAGS += -Ofast
# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

GIT_COMMIT_HASH = $$system(git rev-parse --verify HEAD)
DEFINES += GIT_COMMIT_HASH="\\\"$$GIT_COMMIT_HASH\\\""
DEFINES += BUTTONS
DEFINES += PROGRAM_NAME=\\\"Dashboard_PazNG\\\"

INCLUDEPATH += DashboardGeneral
CONFIG -= qtquickcompiler

SOURCES += \
    DashboardGeneral/DashBoardClasses/application/calculateconsumptionenergy.cpp \
    DashboardGeneral/DashBoardClasses/application/calculatemileage.cpp \
    DashboardGeneral/DashBoardClasses/application/dashboardclass.cpp \
    DashboardGeneral/DashBoardClasses/application/datetimereadclass.cpp \
    DashboardGeneral/DashBoardClasses/application/fpstext.cpp \
    DashboardGeneral/DashBoardClasses/application/menuclass.cpp \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/addrcache.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/blockhash.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/codetable.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/decodetable.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/encodetable.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/headerparser.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/instruction_map.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/jsonwriter.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/logging.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/varint_bigendian.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/vcdecoder.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/vcdiffengine.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/vcencoder.cc \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/zlib/adler32.c \
    DashboardGeneral/DashBoardClasses/copylinyxlogmessage.cpp \
    DashboardGeneral/DashBoardClasses/hardware/backlightcontrolclass.cpp \
    DashboardGeneral/DashBoardClasses/hardware/button.cpp \
    DashboardGeneral/DashBoardClasses/hardware/gpio.cpp \
    DashboardGeneral/DashBoardClasses/hardware/pwm.cpp \
    DashboardGeneral/DashBoardClasses/logtofile.cpp \
    DashboardGeneral/DashBoardClasses/trans.cpp \
    DashboardGeneral/additionaltask.cpp \
    DashboardGeneral/busComponentsClasses/adas.cpp \
    DashboardGeneral/busComponentsClasses/doors.cpp \
    DashboardGeneral/busComponentsClasses/exteriorlightning.cpp \
    DashboardGeneral/busComponentsClasses/primarybuscomponent.cpp \
    DashboardGeneral/busComponentsClasses/tachograph.cpp \
    DashboardGeneral/busComponentsClasses/tire.cpp \
    DashboardGeneral/can/canisotphandler.cpp \
    DashboardGeneral/canDataBase/canDataClass.cpp \
    DashboardGeneral/canDataBase/canMessageClass.cpp \
    DashboardGeneral/canDataBase/canSignalClass.cpp \
    DashboardGeneral/can/can_bus.cpp \
    DashboardGeneral/common_func.cpp \
    DashboardGeneral/qml_interface.cpp \
    busComponentsClasses/brakesystem.cpp \
    busComponentsClasses/businterior.cpp \
    busComponentsClasses/doorsPaz.cpp \
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
    DashboardGeneral/DashBoardClasses/application/calculateconsumptionenergy.h \
    DashboardGeneral/DashBoardClasses/application/calculatemileage.h \
    DashboardGeneral/DashBoardClasses/application/dashboardclass.h \
    DashboardGeneral/DashBoardClasses/application/datetimereadclass.h \
    DashboardGeneral/DashBoardClasses/application/fpstext.h \
    DashboardGeneral/DashBoardClasses/application/menuclass.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/addrcache.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/blockhash.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/checksum.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/codetable.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/compile_assert.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/decodetable.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/google/codetablewriter_interface.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/google/encodetable.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/google/format_extension_flags.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/google/jsonwriter.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/google/output_string.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/google/vcdecoder.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/google/vcencoder.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/headerparser.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/instruction_map.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/logging.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/output_string_crope.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/rolling_hash.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/testing.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/unique_ptr.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/varint_bigendian.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/vcdecoder_test.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/vcdiff_defs.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/vcdiffengine.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/zlib/zconf.h \
    DashboardGeneral/DashBoardClasses/application/open-vcdiff/zlib/zlib.h \
    DashboardGeneral/DashBoardClasses/copylinyxlogmessage.h \
    DashboardGeneral/DashBoardClasses/hardware/backlightcontrolclass.h \
    DashboardGeneral/DashBoardClasses/hardware/button.h \
    DashboardGeneral/DashBoardClasses/hardware/gpio.h \
    DashboardGeneral/DashBoardClasses/hardware/pwm.h \
    DashboardGeneral/DashBoardClasses/logtofile.h \
    DashboardGeneral/DashBoardClasses/trans.h \
    DashboardGeneral/additionaltask.h \
    DashboardGeneral/busComponentsClasses/adas.h \
    DashboardGeneral/busComponentsClasses/doors.h \
    DashboardGeneral/busComponentsClasses/exteriorlightning.h \
    DashboardGeneral/busComponentsClasses/primarybuscomponent.h \
    DashboardGeneral/busComponentsClasses/tachograph.h \
    DashboardGeneral/busComponentsClasses/tire.h \
    DashboardGeneral/can/canisotphandler.h \
    DashboardGeneral/can/uds.h \
    DashboardGeneral/canDataBase/canDB_Libs.h \
    DashboardGeneral/canDataBase/canDataClass.h \
    DashboardGeneral/canDataBase/canMessageClass.h \
    DashboardGeneral/canDataBase/canSignalClass.h \
    DashboardGeneral/can/can_bus.h \
    DashboardGeneral/common_func.h \
    DashboardGeneral/qml_interface.h \
    DashboardGeneral/signal_lamp.h \
    busComponentsClasses/brakesystem.h \
    busComponentsClasses/businterior.h \
    busComponentsClasses/doorsPaz.h \
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
