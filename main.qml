import QtQuick 2.9
import QtQuick.Window 2.3
import "DashboardGeneral/qmlUserClass"
import "DashboardGeneral/qmlUserClass/baseClasses"
import QtMultimedia 5.9
//import QtQuick.Controls 2.11
import QtQuick.Controls 2.0
import QtQml 2.0

Item{    
    id: baseElement
    width: 1920
    height: 720
    visible: true
    clip: true
    property bool buttonIsVisible: false
    //изменения прозрачности
    property int generalOpacity: 1
    opacity: mainItem.opacity
    Component.onCompleted: {
        //a_incLogoOpacity.running = true
        a_decLogoOpacity.running = true
        a_incMainItemOpacity.running = true
        //a_incDownTextRowOpacity.running = true
        //        brakeSystem.dashboardLoadFinished()
        //        tractionBattery.dashboardLoadFinished()
        //        motor.dashboardLoadFinished()
        //        suspension.dashboardLoadFinished()
        //        exteriorLightning.dashboardLoadFinished()
        //        driverCabin.dashboardLoadFinished()
        //        busInterior.dashboardLoadFinished()
        background.bootAnimation = true
    }
    //    Audio{
    //        id: warningSound
    //        source: "qrc:/sound/warningSound.wav"
    //        volume: 0.0
    //    }
    //    Audio{
    //        id: errorSound
    //        source: "qrc:/sound/errorSound.wav"
    //        volume: 0.0
    //    }

    Image {
        id: background
        x: -3
        y: 0
        width: 1926
        height: 720
        visible: true
        sourceSize.height: 0
        sourceSize.width: 0
        source: "DashboardGeneral/images/backgroundMain.png"
        z: 0
        fillMode: Image.PreserveAspectFit
        property bool bootAnimation: true
    }
    Image {
        id: fontTest
        x: -3
        y: 0
        width: 1926
        height: 720
        visible: true
        sourceSize.height: 0
        sourceSize.width: 0
        source: "img/signalLamps_font_PazNG.jpg"
        z: 0
        fillMode: Image.PreserveAspectFit
        property bool bootAnimation: true
    }
    Loader {
        id: menuLoader
        x: 621
        y: -63
        width: 1155
        height: 600
        anchors.verticalCenterOffset: 13
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        asynchronous: true
        active: false
        source: "qrc:/menu.qml"
        z: 2

        //        Rectangle {
        //            id: resetMileageWindow
        //            x: 490
        //            y: 230
        //            width: 500
        //            height: 200
        //            color: "#302e40"
        //            radius: 50
        //            visible: false
        //            border.color: "#ffffff"
        //            border.width: 2
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            anchors.verticalCenter: parent.verticalCenter

        //            Text {
        //                id: textResetMileage
        //                x: 56
        //                y: 32
        //                width: 500
        //                height: 100
        //                color: "#ffffff"
        //                text: qsTr("Вы хотите сбросить суточный\nпробег? Да(+) Нет(-)")
        //                font.family: "Arial"
        //                horizontalAlignment: Text.AlignHCenter
        //                verticalAlignment: Text.AlignVCenter
        //                anchors.horizontalCenter: parent.horizontalCenter
        //                anchors.verticalCenter: parent.verticalCenter
        //                font.pixelSize: 35
        //            }
        //        }
    }

    PressureCircuitBar_C {
        id: brakePressureCircuit_1
        x: 303
        y: 310
        z: -1
        size: 650
        arcOffset: 276.5
        lineWidth: 38
        arcMax: 32.5
        actualPressure: 0
    }

    PressureCircuitBar_C {
        id: brakePressureCircuit_2
        x: 351
        y: 316
        z: -1
        arcOffset: 233.5
        size: 740
        opacity: 1
        lineWidth: 35
        arcMax: 28.3
        actualPressure: 0
    }

    ProgressCycle_C {
        id: voltageBar
        property double arcMax: 32.5
        property double koef: arcMax / (maxValue - minValue)
        property double actualValue: 100
        property double minValue: 0
        property double maxValue: 100
        property double lowValue: 10
        x: 1264
        y: 48
        arcEnd: 82
        z: -1
        arcBegin: arcEnd - ((actualValue - minValue) * koef*1.05)
        size: 625
        arcOffset: 0
        lineWidth: 38.5
        beginAnimation: false
        endAnimation: false
        isPie: false
        colorCircleStartGrad:"#b7b7b7"
        colorCircleStopGrad: "#b7b7b7"
        opacity: 1

        function updateValue(inputValue){
            if (inputValue > maxValue) actualValue = maxValue
            else if (inputValue < minValue) actualValue = minValue
            else actualValue = inputValue
            if (actualValue < lowValue) {
                voltageBar.colorCircleStopGrad= "#ff0000"
                voltageBar.colorCircleStartGrad= "#ff0000"
            }
            else {
                voltageBar.colorCircleStopGrad = "#b7b7b7"
                voltageBar.colorCircleStartGrad = "#b7b7b7"
            }
        }
    }

    ProgressCycle_C {
        id: socBar
        property double arcMax: 32.5
        property double koef: arcMax / (maxValue - minValue)
        property double actualValue: 120
        property double minValue: 40
        property double maxValue: 120
        property double highValue: 113

        x: 1259
        y: 80
        arcEnd: 30.5
        z: -1
        arcBegin: arcEnd - ((actualValue - minValue)  * koef * 1.03)
        size: 625
        arcOffset: 98
        lineWidth: 36
        beginAnimation: false
        endAnimation: false
        isPie: false
        colorCircleStartGrad:"#b7b7b7"
        colorCircleStopGrad: "#b7b7b7"
        opacity: 1

        function updateValue(inputValue){
            if (inputValue > maxValue) actualValue = maxValue
            else if (inputValue < minValue) actualValue = minValue
            else actualValue = inputValue
            if (actualValue > highValue) {
                socBar.colorCircleStopGrad= "#ff0000"
                socBar.colorCircleStartGrad= "#ff0000"
                //soc.source = "/DashboardGeneral/images/signalLamps/motorSystem/engineCoolantTempFailure.png"
            }
            else {
                socBar.colorCircleStopGrad = "#b7b7b7"
                socBar.colorCircleStartGrad = "#b7b7b7"
                //soc.source = "/DashboardGeneral/images/signalLamps/motorSystem/high_temp_grey.png"
            }
        }
    }

    PropertyAnimation {
        id: a_incLogoOpacity
        target: logo
        properties: "opacity"
        to: 1
        duration: 1500
        onStopped: {
            a_decLogoOpacity.running = true
            a_incMainItemOpacity.running = true
        }
    }
    DynamicTextRow_C {
        id: downDynamicTextRow
        x: 612
        y: 583
        z: 1
        width: 744
        height: 75
        opacity: 0
        color: "#ffffff"
        text: qsTr("")
        font.family: "Arial"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 30
        baseRow: ""
    }
    PropertyAnimation {
        id: a_incDownTextRowOpacity
        target: downDynamicTextRow
        properties: "opacity"
        to: 1
        duration: 1500
    }

    PropertyAnimation {
        id: a_incMainItemOpacity
        target: mainItem
        //target: baseElement
        properties: "opacity"
        to: 1
        duration: 1500
        onStopped: {
            a_speedArrowLaunchUp.running = true
            a_rightArrowLaunchUp.running = true
            signalLamps.signalLampTest = true
        }
    }

    PropertyAnimation {
        id: a_decLogoOpacity
        target: logo
        properties: "opacity"
        to: 0
        duration: 1000
    }
    property int baseTimeArrowRotationForLaunch: 750
    PropertyAnimation {
        id: a_speedArrowLaunchUp
        target: speedArrow
        properties: "rotation"
        from: -90
        to: 120
        duration: baseTimeArrowRotationForLaunch
        onStopped: {
            a_speedArrowLaunchDown.running = true
        }
    }
    PropertyAnimation {
        id: a_speedArrowLaunchDown
        target: speedArrow
        properties: "rotation"
        from: 120
        to: -90
        duration: baseTimeArrowRotationForLaunch
        onStopped: {
            background.bootAnimation = false
            signalLamps.signalLampTest = false
            brakeSystem.dashboardLoadFinished()
            //tractionBattery.dashboardLoadFinished()
            motor.dashboardLoadFinished()
            suspension.dashboardLoadFinished()
            exteriorLightning.dashboardLoadFinished()
            driverCabin.dashboardLoadFinished()
            busInterior.dashboardLoadFinished()
        }
    }
    PropertyAnimation {
        id: a_rightArrowLaunchUp
        target: rightArrow
        properties: "rotation"
        from: 90
        to: -120
        duration: baseTimeArrowRotationForLaunch
        onStopped: {
            a_rightArrowLaunchDown.running = true
        }
    }
    PropertyAnimation {
        id: a_rightArrowLaunchDown
        target: rightArrow
        properties: "rotation"
        from: -120
        to: 90
        duration: baseTimeArrowRotationForLaunch
    }
    Item {
        id: mainItem
        width: 1920
        height: 720
        visible: true
        opacity: generalOpacity // general UI opacity
        Image {
            Door_C {
                id: door_1
                x: 243
                y: 48
                width: 53
                height: 125
                doorNumber: "1"
                visible: true
            }

            Door_C {
                id: door_2
                x: 150
                y: 61
                width: 40
                height: 95
                visible: true
                doorNumber: "2"
            }


            Timer {
                id: timerToggle_3000ms
                interval: 3000; running: false; repeat: true
                property int sourceNumber: 0
                onTriggered: {
                    if (sourceNumber == 0) busImage.source = "/DashboardGeneral/images/busSideView_PazNG.png"
                    if (sourceNumber == 1) busImage.source = "/DashboardGeneral/images/busFrontView_PazNG.png"
                    if (sourceNumber == 2) busImage.source = "/DashboardGeneral/images/busRearView_PazNG.png"
                    sourceNumber ++
                    if (sourceNumber > 2) sourceNumber = 0
                }
            }
            id: busImage
            x: 688
            y: 272
            width: 564
            height: 279
            visible: true
            opacity: 1
            source: "img/busFrontView.png"
            fillMode: Image.PreserveAspectFit
            //            Component.onCompleted: {
            //                timerToggle_3000ms.start()
            //            }
            SignalLamp_C {
                id: rampState_L
                x: 202
                y: 153
                width: 102
                height: 77
                visible: true
                fillMode: Image.PreserveAspectFit
                source: "/DashboardGeneral/images/signalLamps/busExterior/theRampIsOpen.png"
                z: 5
                test: false
                //source: "/DashboardGeneral/images/signalLamps/busExterior/rampSensorMalfunction.png"
            }

            SignalLamp_C {
                id: rearCompartmentIsOpen_L
                x: 62
                y: 92
                width: 34
                height: 38
                test: false
                fillMode: Image.PreserveAspectFit
                visible: true
                source: "/DashboardGeneral/images/signalLamps/busExterior/theEngineCompartmentHatchIsOpen.png"
            }

            SignalLamp_C {
                id: frontCompartment_L
                x: 433
                y: 158
                width: 50
                height: width
                rotation: -10
                fillMode: Image.PreserveAspectFit
                source: "/DashboardGeneral/images/signalLamps/busExterior/frontCompartment.png"
                visible: true
                test: false
            }

        }



        Image {
            id: batteryVoltage
            x: 1830
            y: 96
            width: 50
            height: batteryVoltage.Width
            fillMode: Image.PreserveAspectFit
            source: "DashboardGeneral/images/signalLamps/battery/batHvOn.png"

            Text {
                id: batteryVoltageUnits
                x: -1916
                y: -19
                width: 84
                height: 40
                color: "#aaa4a4"
                text: qsTr("вольт")
                anchors.left: parent.left
                font.pixelSize: 17
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                z: 1
                font.family: "Verdana"
                anchors.leftMargin: -104
            }
        }

        Image {
            id: soc
            x: 1828
            y: 608
            width: 50
            height: soc.Width
            fillMode: Image.PreserveAspectFit
            source: "DashboardGeneral/images/signalLamps/battery/batHvWarning.png"

            Text {
                id: socUnits
                x: -214
                y: 4
                width: 28
                height: 40
                color: "#ffffff"
                text: qsTr("%")
                anchors.left: parent.left
                font.pixelSize: 28
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                anchors.leftMargin: -86
                z: 1
                font.family: "Open Sans"
            }
        }

        FontLoader {
            id: digitalFont
            source: "qrc:/DashboardGeneral/fonts/Digital/Digital_Font.ttf"
            //source: "qrc:/fonts/DIGITALDREAMFAT.ttf"
        }

        RotationAnimator {
            id: rightArrowAnimation
            target: rightArrow
            property int angleForZeroIndication: 0
            property double angleRotation: angleForZeroIndication
            property int maxIndicatorChg: 500
            property int fullRotationChg: 120
            property double angleKoefChg: fullRotationChg/maxIndicatorChg
            property int maxIndicatorDchg: 300
            property int fullRotationDchg: 90
            property double angleKoefDchg: fullRotationDchg/maxIndicatorDchg
            property double previosAngle: angleForZeroIndication
            property int baseDuration: 30
        }


        RotationAnimator {
            id: speedArrowAnimation
            target: speedArrow
            property int angleForZeroIndication: -90
            property double angleRotation: angleForZeroIndication
            property int maxIndicator: 140
            property int fullRotation: 210
            property double angleKoef: fullRotation/maxIndicator
            property double previosAngle: angleForZeroIndication
            property int baseDuration: 30
        }
        Connections {
            target: doors
            onSendDoor1StatusToQml:{
                door_1.checkStatus(doorStatus);
                //console.log(door1Status);
            }
            onSendDoor2StatusToQml:{
                door_2.checkStatus(doorStatus);
                //console.log(door2Status);
            }
            onSendDoor3StatusToQml:{
                door_3.checkStatus(doorStatus);
                //console.log(doorStatus);
            }
        }
        Connections {
            target: dashboardObject
            property string oldIp
            property string skString;
            onSendIpToQml:{
                skString = inputStr
                if (skString.indexOf("10.0") !== -1 || skString.indexOf("10.6") !== -1){
                    buttonIsVisible = true
                }
                else{
                    buttonIsVisible = false
                }

                //console.log()
                dynamicTextRow.deleteRowFromArray(oldIp)
                dynamicTextRow.insertRowToArray(inputStr)
            }
        }
        Connections  {
            target: connectionFromCpp // Указываем целевое соединение
            // Объявляем и реализуем функцию, как параметр
            // объекта и с имененем похожим на название сигнала
            // Разница в том, что добавляем в начале on и далее пишем
            // с заглавной буквы
            //
            property int test: -1
            property bool testBool: true
            onSendResetActualMileageToQml: {
                resetMileageWindow.visible = true
                //console.log("onSendResetActualMileageToQml")
            }
            property bool buttonOkStatus: false
            property bool buttonMinusStatus: false
            onSendButtonOkStateToQml:{
                if (state) {
                    buttonOkStatus = true
                }
                else buttonOkStatus = false
                if (state && menuLoader.active === false && buttonMinusStatus === false) {
                    menuLoader.active = true
                }
            }
            onSendButtonMenuStateToQml: {
                if (state && menuLoader.active === false) {
                    menuLoader.active = true
                }
                //                if (state && menuLoader.active === true) {
                //                    menuLoader.active = false
                //                }
            }
            onSendAddErrorCanSignalToQml: {
                dynamicTextRow.addCanSignalError(canSignalName);
            }
            onSendDeleteErrorCanSignalToQml: {
                dynamicTextRow.deleteCanSignalError(canSignalName);
            }
            //            onSendAddMissedCanMsgToQml:{
            //                //if (canMsgName == "ASC1_A") console.log("ASC1_A")
            //                downDynamicTextRow.addCanMsgMissedError(canMsgName);
            //            }
            //            onSendDeleteMissedCanMsgToQml:{
            //                //if (canMsgName == "ASC1_A") console.log("not ASC1_A")
            //                downDynamicTextRow.deleteCanMsgMissedError(canMsgName);
            //            }
            onSendTimeToQml: {
                actualTime.time_str = timeRx;
                //                if (testBool) {
                //                    menuLoader.active = true
                //                    testBool = false
                //                    upperDynamicTextRow.insertRowToArray("Ошибка двигателя")
                //                    upperDynamicTextRow.insertRowToArray("Ошибка батареи")
                //                    upperDynamicTextRow.insertRowToArray("Ошибка компрессора")
                //                    upperDynamicTextRow.insertRowToArray("Ошибка ЭБСУ")
                //                    downDynamicTextRow.insertRowToArray("Неисправностей не обнаружено")
                //                    upperDynamicTextRow.insertRowToArray("Ошибка ЭБСУ")
                //                }
            }
            onSendDateToQml: {
                actualDate.date_str = dateRx;
            }
            property string translateDay1: qsTr("пн")
            property string translateDay2: qsTr("вт")
            property string translateDay3: qsTr("ср")
            property string translateDay4: qsTr("чт")
            property string translateDay5: qsTr("пт")
            property string translateDay6: qsTr("сб")
            property string translateDay7: qsTr("вс")
            onSendWeekDayToQml: {
                actualDate.weekDay_str = qsTr(weekDayRx);
            }
            onSendEstimatedKmRangeToQml:{
                estimatedKilometersRangeValue.text = inputFloat.toFixed(0)
            }
            onSendTotalMileageToQml: {
                totalMileageValue.text = totalMileageCalc;
            }
            onSendActualMileageToQml: {
                actualMileageValue.text = actualMileageCalc;
            }
            onSendErrorMcp2515ToQml:{
                if (errorMcp2515) dynamicTextRow.insertRowToArray(qsTr("Внутренняя ошибка, нет доступного CAN интерфейса"))
                else dynamicTextRow.deleteRowFromArray(qsTr("Внутренняя ошибка, нет доступного CAN интерфейса"))
            }
        }
        Connections {
            target: canBus
            onSendAddCanErrorToQml:{
                //console.log(error_str)
                dynamicTextRow.addCanBusError(error_str)
            }
            onSendDeleteCanErrorToQml:{
                dynamicTextRow.deleteCanBusError(error_str)
            }
        }
        Connections {
            target: busInterior
            onSendTempOutsideToQml: {
                tempOutsideValue.text = inputString
            }
            onSendTempInsideToQml: {
                tempCabinValue.text = inputString
            }
            onSendTempSalonToQml: {
                tempSalonValue.text = inputString
            }
            onSendRampStatusToQml: {
                if (inputUint === 2) {
                    rampState_L.source = "/DashboardGeneral/images/signalLamps/busExterior/rampSensorMalfunction.png"
                    rampState_L.lampOn()
                }
                else if (inputUint === 1) {
                    rampState_L.source = "/DashboardGeneral/images/signalLamps/busExterior/theRampIsOpen.png"
                    rampState_L.lampOn()
                }
                else{
                    rampState_L.lampOff()
                }
            }
            onSendRearCompartmentStatusToQml: {
                if (inputUint) {
                    //warningSound.play()
                    rearCompartmentIsOpen_L.lampOn()
                }
                else rearCompartmentIsOpen_L.lampOff()
            }
            onSendFrontCompartmentStatusToQml: {
                if (inputUint){
                    //warningSound.play()
                    frontCompartment_L.lampOn()
                }
                else frontCompartment_L.lampOff()
            }
        }
        Connections {
            target: motor
            onSendSpeedToQml: {
                speedArrowAnimation.angleRotation = speedArrowAnimation.angleKoef * inputFloat + speedArrowAnimation.angleForZeroIndication
                if (background.bootAnimation === false) {
                    speedArrowAnimation.from = speedArrowAnimation.previosAngle
                    speedArrowAnimation.to = speedArrowAnimation.angleRotation
                    speedArrowAnimation.duration = speedArrowAnimation.baseDuration
                    speedArrowAnimation.start()
                    speedArrowAnimation.previosAngle = speedArrowAnimation.angleRotation
                    speedDigital.fontSizeMode = (inputFloat >= 100) ? 150 : 100
                    speedDigital.text = inputFloat.toFixed(0)
                }
            }
            onSendEngineSpeedToQml: {
                //console.log(inputFloat)
                if (inputFloat <=0){
                    rightArrowAnimation.angleRotation = rightArrowAnimation.angleKoefChg * inputFloat

                }
                else if (inputFloat > 0){
                    rightArrowAnimation.angleRotation = rightArrowAnimation.angleKoefDchg * inputFloat
                }
                if (background.bootAnimation === false){
                    rightArrowAnimation.from = rightArrowAnimation.previosAngle
                    rightArrowAnimation.to = rightArrowAnimation.angleRotation
                    rightArrowAnimation.duration = rightArrowAnimation.baseDuration
                    rightArrowAnimation.start()
                    rightArrowAnimation.previosAngle = rightArrowAnimation.angleRotation
                }
            }
            onSendFuelLevelToQml: {
                if (background.bootAnimation === false) {
                    voltageBar.updateValue(inputInt)
//                    if (inputInt <= voltageBar.lowValue) {
//                        if(batteryVoltage.source == "/DashboardGeneral/images/signalLamps/motorSystem/low_fuel_grey.png"){
//                            //warningSound.play()
//                        }
//                        batteryVoltage.source = "/DashboardGeneral/images/signalLamps/motorSystem/lowFuel.png";
//                    }
//                    else batteryVoltage.source = "/DashboardGeneral/images/signalLamps/motorSystem/low_fuel_grey.png";
                }
            }
            onSendEngineTempToQml: {
                if (background.bootAnimation === false) {
                    socBar.updateValue(inputFloat)
                }
            }
        }
        Connections {
            target: brakeSystem
            onSendPressureCircuit1ToQml: {
                if (background.bootAnimation === false) {
                    brakePressureCircuit_1.updatePressure(inputFloat)
                }
            }
            onSendPressureCircuit2ToQml: {
                if (background.bootAnimation === false) {
                    brakePressureCircuit_2.updatePressure(inputFloat)
                }
            }
            onSendPressureCircuit1LampToQml: {
                if (inputBool) {
                    //errorSound.play()
                    brakeCircuit1_L.source = "/DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit1Failure.png"
                }
                else brakeCircuit1_L.source = "/DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit1.png"
            }
            onSendPressureCircuit2LampToQml: {
                if (inputBool) {
                    //errorSound.play()
                    brakeCircuit2_L.source = "/DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit2Failure.png"
                }
                else brakeCircuit2_L.source = "/DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit2.png"
            }
        }
        Connections {
            target: menuLoader.item
            onMenuOff: {
                if (menuStateOff === true) {
                    //console.log("main")
                    menuLoader.active = false
                }
            }
        }
        Image {
            id: dials
            x: 0
            y: 0
            width: 1920
            height: 720
            sourceSize.height: 0
            sourceSize.width: 0
            visible: true
            z: 0
            fillMode: Image.Pad
            source: "img/dials.png"

            Item{

                id: actualMileageItem
                x: 1450
                y: 670
                width: 420
                height: 50
                anchors.right: parent.right
                anchors.rightMargin: 20

                Text {
                    id: actualMileageText
                    x: -23
                    y: -2
                    width: 280
                    height: 50
                    color: "#ffffff"
                    text: qsTr("суточный пробег:")
                    anchors.right: actualMileageValue.left
                    anchors.rightMargin: 43
                    font.family: "Arial"
                    font.pixelSize: 35
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                }

                Text {
                    id: actualMileageValue
                    x: 300
                    y: -2
                    height: 50
                    color: "#ffffff"
                    text: qsTr("250")
                    anchors.right: actualMileageUnit.left
                    anchors.rightMargin: 9
                    font.family: "Arial"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: 35
                }

                Text {
                    id: actualMileageUnit
                    x: 368
                    y: -2
                    height: 50
                    color: "#ffffff"
                    text: qsTr("км")
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.family: "Arial"
                    font.pixelSize: 35
                }
            }

            Item{
                id: tempOutside
                x: 1515
                y: 10
                width: 135
                height: 40
                Text {
                    id: tempOutsideValue
                    y: 1
                    width: 55
                    height: 40
                    color: "#ffffff"
                    text: qsTr("-17°")
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignTop
                    anchors.leftMargin: 78
                    z: 1
                    horizontalAlignment: Text.AlignRight
                    font.family: "Open Sans"
                    font.pixelSize: 35
                }

                Image {
                    id: tempOutsideIcon
                    x: 21
                    y: 4
                    width: 45
                    height: 39
                    source: "DashboardGeneral/images/nature.png"
                    fillMode: Image.PreserveAspectFit
                }
            }


            Item {
                id: tempCabin
                x: 1650
                y: 10
                width: 135
                height: 40
                Text {
                    id: tempCabinValue
                    y: 0
                    width: 70
                    height: 40
                    color: "#ffffff"
                    text: qsTr("+20°")
                    anchors.left: parent.left
                    font.pixelSize: 35
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignTop
                    anchors.leftMargin: 63
                    font.family: "Open Sans"
                    z: 1
                }

                Image {
                    id: tempCabinIcon
                    x: 18
                    y: 8
                    width: 45
                    height: 39
                    source: "DashboardGeneral/images/driverCabin.png"
                    fillMode: Image.Stretch
                }
            }

            Item {
                id: tempSalon
                x: 1798
                y: 10
                width: 135
                height: 40
                Text {
                    id: tempSalonValue
                    y: 0
                    width: 70
                    height: 40
                    color: "#ffffff"
                    text: qsTr("+24°")
                    anchors.left: parent.left
                    font.pixelSize: 35
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignTop
                    anchors.leftMargin: 40
                    font.family: "Open Sans"
                    z: 1
                }

                Image {
                    id: tempSalonIcon
                    x: -6
                    y: 8
                    width: 45
                    height: 39
                    source: "DashboardGeneral/images/salon.png"
                    fillMode: Image.Stretch
                }
            }

            Rectangle {
                id: speedCover
                x: 236
                y: 249
                width: 250
                height: speedCover.width
                z: 1
                color: "#00000000"
                radius: speedCover.width / 2
                Text {
                    id: speedDigital
                    x: 55
                    y: 75
                    width: 167
                    height: 89
                    color: "#ffffff"
                    text: qsTr("0")
                    z: 1
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family:  "Arial"
                    font.pixelSize: 115
                }

                Image {
                    id: speedArrow
                    x: -146
                    y: 104
                    width: 289
                    height: 38
                    z: -1
                    fillMode: Image.PreserveAspectFit
                    source: "DashboardGeneral/images/arrowIndicators/arrow.png"
                    transformOrigin:Item.Right
                    rotation: -90
                }

                Text {
                    id: speedUnit
                    x: 165
                    y: 296
                    color: "#cccccc"
                    text: qsTr("км/ч")
                    font.family: "Arial"
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Text {
                    id: speedUnit1
                    x: 116
                    y: 168
                    color: "#cccccc"
                    text: qsTr("км/ч")
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
                }
            }

            Rectangle {
                id: rightCover
                x: 1430
                y: 235
                width: 250
                height: rightCover.width
                color: "#00000000"
                radius: rightCover.width / 2
                z: 0
                Image {
                    id: rightArrow
                    x: 111
                    y: 118
                    width: 289
                    height: 38
                    rotation: 90
                    z: -1
                    fillMode: Image.PreserveAspectFit
                    source: "DashboardGeneral/images/arrowIndicators/arrow.png"
                    mirror: true
                    transformOrigin:Item.Left

                }

                Item {
                    id: estimatedRange
                    x: 12
                    y: 103
                    width: 208
                    height: 60

                    Text {
                        id: estimatedKilometersRangeValue
                        x: 9
                        y: 2
                        width: 90
                        height: 60
                        color: "#ffffff"
                        text: qsTr("174")
                        font.family: "Open Sans"
                        font.pixelSize: 60
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter

                        Text {
                            id: estimatedKilometersRangeText
                            x: 0
                            y: 0
                            width: estimatedKilometersRangeValue.width + 40
                            height: estimatedKilometersRangeValue.height
                            color: "#ffffff"
                            text: qsTr("км")
                            font.pixelSize: estimatedKilometersRangeValue.font.pixelSize / 2
                            font.family: "Arial"
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Image {

                        id: estimatedRangeImage
                        x: 80
                        y: 15
                        width: 100
                        height: 42
                        fillMode: Image.PreserveAspectFit
                        source: "DashboardGeneral/images/estimated_range_new.png"
                    }
                }

                Text {
                    id: rightUnit
                    x: 0
                    y: 300
                    width: 86
                    height: 51
                    color: "#cccccc"
                    text: "Ампер"
                    textFormat: Text.RichText
                    font.pixelSize: 25
                    font.family: "Open Sans"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Rectangle{
                id: rectangleRow
                x: 390
                y: 580
                width: 1138
                height: 80
                color: "#000000"
                radius: 15
                border.color: "#c6c6cd"
                border.width: 5
                DynamicTextRow_C{
                    id: dynamicTextRow
                    width: 1040
                    text: "Неисправностей не обнаружено"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Item {
                id: totalMileageItem
                x: 15
                y: 670
                width: 310
                height: 50


                Text {
                    id: totalMileageText
                    y: -5
                    height: 50
                    color: "#ffffff"
                    text: qsTr("пробег:")
                    anchors.left: parent.left
                    anchors.leftMargin: 7
                    font.family: "Arial"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 35
                }

                Text {
                    id: totalMileageValue
                    y: -5
                    height: 50
                    color: "#ffffff"
                    text: qsTr("9 999 990")
                    anchors.left: totalMileageText.right
                    anchors.leftMargin: 36
                    font.family: "Arial"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: 35
                }

                Text {
                    id: totalMileageUnit
                    y: -5
                    width: 50
                    height: 50
                    color: "#ffffff"
                    text: qsTr("км")
                    anchors.left: totalMileageValue.right
                    anchors.leftMargin: 1
                    font.family: "Arial"
                    font.pixelSize: 35
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Date_C {
                id: actualDate
                x: 150
                y: 15
                width: 200
                height: 50
                date_str: "13.01.23"
                weekDay_str: "пт"
            }

            Time_C {
                id: actualTime
                x: 0
                y: 10
                width: 151
                height: 56
                time_str: "15:05"
                timePixelSize: 60
            }
            Row {
                id: buttonRow
                x: 379
                y: 672
                width: 1162
                height: 49
                visible: buttonIsVisible
                leftPadding: 200
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 15

                Button {
                    id: button
                    text: qsTr("Menu")
                    anchors.verticalCenter: parent.verticalCenter
                    visible: buttonIsVisible
                    onPressed: {
                        connectionFromCpp.recMenuBtn(true)
                    }
                }

                Button {
                    id: button1
                    text: qsTr("Back")
                    anchors.verticalCenter: parent.verticalCenter
                    visible: buttonIsVisible
                    onPressed: {
                        connectionFromCpp.recBackBtn(true)
                    }
                }

                Button {
                    id: button2
                    text: qsTr("Ok")
                    anchors.verticalCenter: parent.verticalCenter
                    visible: buttonIsVisible
                    onPressed: {
                        connectionFromCpp.recOkBtn(true)
                    }
                }

                Button {
                    id: button3
                    text: qsTr("Left")
                    anchors.verticalCenter: parent.verticalCenter
                    visible: buttonIsVisible
                    onPressed: {
                        connectionFromCpp.recLeftBtn(true)
                    }
                }

                Button {
                    id: button4
                    text: qsTr("Right")
                    anchors.verticalCenter: parent.verticalCenter
                    visible: buttonIsVisible
                    onPressed: {
                        connectionFromCpp.recRightBtn(true)
                    }
                }

                Button {
                    id: button5
                    text: qsTr("Up")
                    anchors.verticalCenter: parent.verticalCenter
                    visible: buttonIsVisible
                    onPressed: {
                        connectionFromCpp.recUpBtn(true)
                    }
                }

                Button {
                    id: button6
                    text: qsTr("Down")
                    anchors.verticalCenter: parent.verticalCenter
                    visible: buttonIsVisible
                    onPressed: {
                        connectionFromCpp.recDownBtn(true)
                    }
                }
            }

            SignalLamps {
                id: signalLamps
                x: 0
                y: 0
                width: 1920
                height: 720
            }

            Image {
                id: brakeCircuit1_L
                x: 25
                y: 79
                width: 60
                height: brakeCircuit1_L.width
                visible: true
                source: "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit1.png"
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: brakeCircuit2_L
                x: 25
                y: 600
                width: 60
                height: brakeCircuit2_L.width
                visible: true
                source: "/DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit2.png"
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: brakePressure1Unit
                x: 93
                y: 84
                width: 50
                height: 50
                color: "#cccccc"
                text: qsTr("<u>кгс</u><br>см²")
                fontSizeMode: Text.Fit
                font.family: "Arial"
                font.pixelSize: 100
                minimumPointSize: 20
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: brakePressure2Unit
                x: 93
                y: 605
                width: 50
                height: 50
                color: "#cccccc"
                text: qsTr("<u>кгс</u><br>см²")
                fontSizeMode: Text.Fit
                font.family: "Arial"
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 100
                minimumPointSize: 20
                horizontalAlignment: Text.AlignLeft
            }

        }
    }
}


