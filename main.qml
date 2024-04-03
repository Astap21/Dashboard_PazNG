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
        id: fuelBar
        property double arcMax: 32.5
        property double koef: arcMax / (maxValue - minValue)
        property double actualValue: 100
        property double minValue: 0
        property double maxValue: 100
        property double lowValue: 10
        x: 1264
        y: 51
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
                fuelBar.colorCircleStopGrad= "#ff0000"
                fuelBar.colorCircleStartGrad= "#ff0000"
            }
            else {
                fuelBar.colorCircleStopGrad = "#b7b7b7"
                fuelBar.colorCircleStartGrad = "#b7b7b7"
            }
        }
    }

    ProgressCycle_C {
        id: engineTempBar
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
                engineTempBar.colorCircleStopGrad= "#ff0000"
                engineTempBar.colorCircleStartGrad= "#ff0000"
                engineTempImage.source = "/DashboardGeneral/images/signalLamps/motorSystem/engineCoolantTempFailure.png"
            }
            else {
                engineTempBar.colorCircleStopGrad = "#b7b7b7"
                engineTempBar.colorCircleStartGrad = "#b7b7b7"
                engineTempImage.source = "/DashboardGeneral/images/signalLamps/motorSystem/high_temp_grey.png"
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
            a_currentArrowLaunchUp.running = true
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
        id: a_currentArrowLaunchUp
        target: engineSpeedArrow
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
        target: engineSpeedArrow
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
                x: 271
                y: 60
                width: 70
                height: 159
                doorNumber: "1"
                visible: true
            }

            Door_C {
                id: door_2
                x: 109
                y: 67
                width: 35
                height: 113
                visible: true
                doorNumber: "2"
            }


            Timer {
                id: timerToggle_3000ms
                interval: 3000; running: false; repeat: true
                property int sourceNumber: 0
                onTriggered: {
                    if (sourceNumber == 0) busImage.source = "/DashboardGeneral/images/busSideView.png"
                    if (sourceNumber == 1) busImage.source = "/DashboardGeneral/images/busFrontView.png"
                    if (sourceNumber == 2) busImage.source = "/DashboardGeneral/images/busRearView.png"
                    sourceNumber ++
                    if (sourceNumber > 2) sourceNumber = 0
                }
            }
            id: busImage
            x: 757
            y: 254
            width: 450
            height: 255
            visible: true
            opacity: 1
            source: "DashboardGeneral/images/busFrontView.png"
            fillMode: Image.PreserveAspectFit
            //            Component.onCompleted: {
            //                timerToggle_3000ms.start()
            //            }
            SignalLamp_C {
                id: rampState_L
                x: 83
                y: 142
                width: 61
                height: 77
                visible: true
                fillMode: Image.PreserveAspectFit
                source: "/DashboardGeneral/images/signalLamps/busExterior/theRampIsOpen.png"
                test: false
                //source: "/DashboardGeneral/images/signalLamps/busExterior/rampSensorMalfunction.png"
            }

            SignalLamp_C {
                id: rearCompartmentIsOpen_L
                x: 0
                y: 109
                width: 34
                height: 38
                test: false
                fillMode: Image.PreserveAspectFit
                visible: true
                source: "/DashboardGeneral/images/signalLamps/busExterior/theEngineCompartmentHatchIsOpen.png"
            }

            SignalLamp_C {
                id: frontCompartment_L
                x: 383
                y: 169
                width: 55
                height: width
                rotation: -10
                fillMode: Image.PreserveAspectFit
                source: "/DashboardGeneral/images/signalLamps/busExterior/frontCompartment.png"
                visible: true
                test: false
            }

            Door_C {
                id: door_3
                x: 40
                y: 73
                width: 26
                height: 90
                visible: true
                doorNumber: "3"
            }

        }



        Image {
            id: fuelImage
            x: 1845
            y: 98
            width: 35
            height: fuelImage.Width
            fillMode: Image.PreserveAspectFit
            source: "DashboardGeneral/images/signalLamps/motorSystem/low_fuel_grey.png"
        }

        Image {
            id: engineTempImage
            x: 1845
            y: 603
            width: 50
            height: engineTempImage.Width
            fillMode: Image.PreserveAspectFit
            source: "DashboardGeneral/images/signalLamps/motorSystem/high_temp_grey.png"

            Text {
                id: tempOutsideUnits1
                x: -214
                y: 5
                width: 20
                height: 40
                color: "#ffffff"
                text: qsTr("°C")
                anchors.left: parent.left
                font.pixelSize: 20
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                anchors.leftMargin: -39
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
            id: engineSpeedArrowAnimation
            target: engineSpeedArrow
            property int angleForZeroIndication: 90
            property double angleRotation: angleForZeroIndication
            property int maxIndicator: -3500
            property int fullRotation: -210
            property double angleKoef: fullRotation/maxIndicator
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
                engineSpeedArrowAnimation.angleRotation = engineSpeedArrowAnimation.angleForZeroIndication - engineSpeedArrowAnimation.angleKoef * inputFloat
                if (background.bootAnimation === false) {
                    engineSpeedArrowAnimation.from = engineSpeedArrowAnimation.previosAngle
                    engineSpeedArrowAnimation.to = engineSpeedArrowAnimation.angleRotation
                    engineSpeedArrowAnimation.duration = engineSpeedArrowAnimation.baseDuration
                    engineSpeedArrowAnimation.start()
                    engineSpeedArrowAnimation.previosAngle = engineSpeedArrowAnimation.angleRotation
                }
            }
            onSendFuelLevelToQml: {
                if (background.bootAnimation === false) {
                    fuelBar.updateValue(inputInt)
                    if (inputInt <= fuelBar.lowValue) {
                        if(fuelImage.source == "/DashboardGeneral/images/signalLamps/motorSystem/low_fuel_grey.png"){
                            //warningSound.play()
                        }
                        fuelImage.source = "/DashboardGeneral/images/signalLamps/motorSystem/lowFuel.png";
                    }
                    else fuelImage.source = "/DashboardGeneral/images/signalLamps/motorSystem/low_fuel_grey.png";
                }
            }
            onSendEngineTempToQml: {
                if (background.bootAnimation === false) {
                    engineTempBar.updateValue(inputFloat)
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
            source: "DashboardGeneral/images/newDials.png"

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
                    x: 0
                    y: 0
                    height: 50
                    color: "#ffffff"
                    text: qsTr("суточный пробег:")
                    anchors.right: actualMileageValue.left
                    anchors.rightMargin: 55
                    font.family: "Arial"
                    font.pixelSize: 35
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                }

                Text {
                    id: actualMileageValue
                    x: 295
                    y: 0
                    height: 50
                    color: "#ffffff"
                    text: qsTr("000")
                    anchors.right: actualMileageUnit.left
                    anchors.rightMargin: 10
                    font.family: "Arial"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: 35
                }

                Text {
                    id: actualMileageUnit
                    x: 413
                    y: 0
                    height: 50
                    color: "#ffffff"
                    text: qsTr("км")
                    anchors.right: parent.right
                    anchors.rightMargin: 5
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
                    y: 0
                    width: 70
                    height: 40
                    color: "#ffffff"
                    text: qsTr("+25")
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignTop
                    anchors.leftMargin: tempOutsideIcon.width
                    z: 1
                    horizontalAlignment: Text.AlignRight
                    font.family: "Arial"
                    font.pixelSize: 40
                }

                Text {
                    id: tempOutsideUnits
                    x: 145
                    y: 0
                    width: 20
                    height: 40
                    color: "#ffffff"
                    text: qsTr("°")
                    anchors.right: parent.right
                    verticalAlignment: Text.AlignVCenter
                    anchors.rightMargin: 0
                    z: 1
                    font.family: "Arial"
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignLeft
                }

                Image {
                    id: tempOutsideIcon
                    x: 0
                    y: 0
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
                    text: qsTr("+25")
                    anchors.left: parent.left
                    font.pixelSize: 40
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignTop
                    font.family: "Arial"
                    z: 1
                    anchors.leftMargin: tempOutsideIcon.width
                }

                Text {
                    id: tempCabinUnits
                    x: 145
                    y: 0
                    width: 20
                    height: 40
                    color: "#ffffff"
                    text: qsTr("°")
                    anchors.right: parent.right
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
                    z: 1
                    anchors.rightMargin: 0
                }

                Image {
                    id: tempCabinIcon
                    x: 0
                    y: 5
                    width: 45
                    height: 39
                    source: "DashboardGeneral/images/driverCabin.png"
                    fillMode: Image.Stretch
                }
            }

            Item {
                id: tempSalon
                x: 1785
                y: 10
                width: 135
                height: 40
                Text {
                    id: tempSalonValue
                    y: 0
                    width: 70
                    height: 40
                    color: "#ffffff"
                    text: qsTr("+25")
                    anchors.left: parent.left
                    font.pixelSize: 40
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignTop
                    font.family: "Arial"
                    z: 1
                    anchors.leftMargin: tempOutsideIcon.width
                }

                Text {
                    id: tempSalonUnits
                    x: 145
                    y: 0
                    width: 20
                    height: 40
                    color: "#ffffff"
                    text: qsTr("°")
                    anchors.right: parent.right
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
                    z: 1
                    anchors.rightMargin: 0
                }

                Image {
                    id: tempSalonIcon
                    x: 0
                    y: 5
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
                    x: 41
                    y: 69
                    width: 200
                    height: 110
                    color: "#ffffff"
                    text: qsTr("0")
                    z: 1
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family:  "Arial"
                    font.pixelSize: 150
                }

                Image {
                    id: speedArrow
                    x: -146
                    y: 104
                    width: 288
                    height: 38
                    z: -1
                    fillMode: Image.PreserveAspectFit
                    source: "DashboardGeneral/images/arrowIndicators/arrow.png"
                    transformOrigin:Item.Right
                    rotation: -90
                }

                Text {
                    id: speedUnit
                    x: 157
                    y: 301
                    color: "#cccccc"
                    text: qsTr("км/ч")
                    font.family: "Arial"
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Text {
                    id: speedUnit1
                    x: 107
                    y: 185
                    color: "#cccccc"
                    text: qsTr("км/ч")
                    font.pixelSize: 35
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
                }
            }

            Rectangle {
                id: engineCover
                x: 1430
                y: 235
                width: 250
                height: engineCover.width
                color: "#00000000"
                radius: engineCover.width / 2
                z: 0
                Image {
                    id: engineSpeedArrow
                    x: 111
                    y: 118
                    width: 288
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
                        x: 0
                        y: 0
                        width: 90
                        height: 60
                        color: "#ffffff"
                        text: qsTr("174")
                        font.family: "Arial"
                        font.pixelSize: 55
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
                    id: engineSpeedUnit
                    x: -32
                    y: 319
                    color: "#cccccc"
                    textFormat: Text.RichText
                    text: qsTr("x 100 мин<sup><small>-1</small></sup>")
                    font.pixelSize: 25
                    font.family: "Arial"
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
                    y: 0
                    height: 50
                    color: "#ffffff"
                    text: qsTr("пробег:")
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.family: "Arial"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 35
                }

                Text {
                    id: totalMileageValue
                    y: 0
                    height: 50
                    color: "#ffffff"
                    text: qsTr("0000000")
                    anchors.left: totalMileageText.right
                    anchors.leftMargin: 40
                    font.family: "Arial"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: 35
                }

                Text {
                    id: totalMileageUnit
                    y: 0
                    width: 50
                    height: 50
                    color: "#ffffff"
                    text: qsTr("км")
                    anchors.left: totalMileageValue.right
                    anchors.leftMargin: 10
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


