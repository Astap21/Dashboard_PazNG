import QtQuick 2.9
import QtQuick.Window 2.3
import "DashboardGeneral/qmlUserClass"
import "DashboardGeneral/qmlUserClass/baseClasses"
import "DashboardGeneral/qmlUserClass/baseClasses/NG"
import QtMultimedia 5.9
import QtQuick.Controls 2.11
import QtQml 2.11

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
        a_decLogoOpacity.running = true
        a_incMainItemOpacity.running = true
        background.bootAnimation = true
    }
    SoundEffect{
        id: warningSound
        source: "qrc:/DashboardGeneral/sound/warningSound.wav"
        volume: dashboardObject.volumeLevel
    }
    SoundEffect{
        id: errorSound
        source: "qrc:/DashboardGeneral/sound/errorSound.wav"
        volume: dashboardObject.volumeLevel
    }

    Image {
        id: background
        x: -3
        y: 0
        width: 1926
        height: 720
        visible: true
        sourceSize.height: 0
        sourceSize.width: 0
        source: "img/backFon_3.png"
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
        opacity: 0
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
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        asynchronous: true
        active: false
        source: "qrc:/DashboardGeneral/qmlUserClass/menuItem/commonElement/mainMenu.qml"
        z: 2
    }
    EasyProgressBar_C {
        id: brakePressureCircuit_1
        x: 56
        y: 161
        z: -1
        width: 100
        height: 170
        color: "#b7b7b7"
        transformOrigin: Item.Top
        rotation: 8
        maxRotation: 8
        minRotation: 37
        maxValue: 12
        minValue: 0
        lowValue: 6
        maxHeight: 172
        visible: mainItem.opacity > 0.9 ? true : false
    }
    EasyProgressBar_C {
        id: brakePressureCircuit_2
        x: 57
        y: 412
        z: -1
        width: 100
        height: 170
        color: "#b7b7b7"
        transformOrigin: Item.Bottom
        rotation: -8
        maxRotation: -8
        minRotation: -37
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 138
        maxValue: 12
        minValue: 0
        lowValue: 6
        maxHeight: 172
        visible: mainItem.opacity > 0.9 ? true : false
    }
    EasyProgressBar_C {
        id: voltageBar
        x: 1795
        y: 156
        z: -1
        width: 100
        height: 175
        color: "#b7b7b7"
        rotation: -37
        maxRotation: -37
        minRotation: -8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 387
        maxValue: 800
        minValue: 0
        lowValue: 200
        maxHeight: 172
        visible: mainItem.opacity > 0.9 ? true : false
        function updateValue(inputValue){
            if (inputValue > maxValue) actualValue = maxValue
            else if (inputValue < minValue) actualValue = minValue
            else actualValue = inputValue
            height = maxHeight * (actualValue / (maxValue - minValue))
            rotation = ((maxRotation - minRotation) * actualValuePart) + minRotation
            if (actualValue < lowValue) {
                voltageBar.color= "#ff0000"
            }
            else {
                voltageBar.color = "#b7b7b7"
            }
        }
    }
    EasyProgressBar_C {
        id: socBar
        x: 1773
        y: 415
        z: -1
        width: 100
        height: 170
        rotation: 8
        maxRotation: 8
        minRotation: 37
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 135
        maxValue: 100
        lowValue: 20
        maxHeight: 172
        property int criticalLowValue: 10
        function updateValue(inputValue){
            if (inputValue > maxValue) actualValue = maxValue
            else if (inputValue < minValue) actualValue = minValue
            else actualValue = inputValue
            socValue.text = actualValue.toFixed(0) + " %"
            height = maxHeight * (actualValue / (maxValue - minValue))
            rotation = ((maxRotation - minRotation) * actualValuePart) + minRotation
            if (actualValue < criticalLowValue) {
                socBar.color= "#ff0000"
                soc_L.source = "DashboardGeneral/images/signalLamps/battery/batHvWarning.png"
                soc_L.lampToggle()
            }
            else if(actualValue < lowValue) {
                socBar.colorCircleStopGrad= "#ff0000"
                socBar.colorCircleStartGrad= "#ff0000"
                soc_L.source = "DashboardGeneral/images/signalLamps/battery/batHvWarning.png"
                soc_L.lampOn()
            }
            else {
                socBar.color = "#b7b7b7"
                soc_L.source = "DashboardGeneral/images/signalLamps/battery/batHvOff.png"
                soc_L.lampOn()
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
            doors.dashboardLoadFinished()
            adas.dashboardLoadFinished()
            tachograph.dashboardLoadFinished()
            additionalTasks.dashboardLoadFinished()
            calculateMileage.dashboardLoadFinished()
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
        Banner_C{
            id: banner
            width: 600
            height: 300
            z: 1
            visible: false
            //Component.onCompleted: banner.showWarning(10000, "Добрый вечер")
        }
        Image {
            Door_C {
                id: door_1
                x: 182
                y: 46
                width: 55
                height: 131
                doorNumber: "1"
                visible: true
                doorSource: "DashboardGeneral/images/Doors/doorIsOpen.png"
            }

            Door_C {
                id: door_2
                x: 93
                y: 56
                width: 38
                height: 104
                visible: true
                doorNumber: "2"
                doorSource: "DashboardGeneral/images/Doors/doorIsOpen.png"
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
            x: 753
            y: 280
            width: 440
            height: 270
            visible: true
            opacity: 1
            source: "img/busFrontView.png"
            fillMode: Image.PreserveAspectFit
            //            Component.onCompleted: {
            //                timerToggle_3000ms.start()
            //            }
            SignalLamp_C {
                id: rampState_L
                x: 142
                y: 150
                width: 97
                height: 71
                visible: true
                fillMode: Image.PreserveAspectFit
                source: "DashboardGeneral/images/signalLamps/busExterior/theRampIsOpen.png"
                z: 5
                test: false
                //source: "/DashboardGeneral/images/signalLamps/busExterior/rampSensorMalfunction.png"
            }

            SignalLamp_C {
                id: rearCompartmentIsOpen_L
                x: 16
                y: 85
                width: 23
                height: 38
                test: false
                fillMode: Image.PreserveAspectFit
                visible: true
                source: "DashboardGeneral/images/signalLamps/busExterior/theEngineCompartmentHatchIsOpen.png"
            }

            SignalLamp_C {
                id: frontCompartment_L
                x: 363
                y: 147
                width: 55
                height: width
                rotation: -10
                fillMode: Image.PreserveAspectFit
                source: "DashboardGeneral/images/signalLamps/busExterior/frontCompartment.png"
                visible: true
                test: false
            }

        }



        SignalLamp_C {
            id: batteryVoltage_L
            x: 1830
            y: 96
            width: 50
            height: batteryVoltage_L.width
            fillMode: Image.PreserveAspectFit
            source: "DashboardGeneral/images/signalLamps/battery/batHvOn.png"
        }

        Text {
            id: batteryVoltageUnits
            x: 1726
            y: 77
            width: 84
            height: 40
            color: "#aaa4a4"
            text: qsTr("вольт")
            font.pixelSize: 17
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            z: 1
            font.family: "Verdana"
        }

        SignalLamp_C {
            id: soc_L
            x: 1828
            y: 608
            width: 50
            height: soc_L.width
            fillMode: Image.PreserveAspectFit
            source: "DashboardGeneral/images/signalLamps/battery/batHvOff.png"
        }
        Text {
            id: socUnits
            x: 1745
            y: 613
            width: 28
            height: 40
            color: "#ffffff"
            text: qsTr("%")
            font.pixelSize: 28
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            z: 1
            font.family: "Open Sans"
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
            property int maxIndicator: 120
            property int fullRotation: 215
            property double angleKoef: fullRotation/maxIndicator
            property double previosAngle: angleForZeroIndication
            property int baseDuration: 30
        }
        Connections {
            target: doors
            function onSendDoor1StatusToQml(doorStatus){
                door_1.checkStatus(doorStatus);
                if (doorStatus === 3){
                    banner.showErrorFor5s("Несанкционированное открытие дверей!")
                }
                //console.log(door1Status);
            }
            function onSendDoor2StatusToQml(doorStatus){
                door_2.checkStatus(doorStatus);
                if (doorStatus === 3){
                    banner.showErrorFor5s("Несанкционированное открытие дверей!")
                }
                //console.log(door2Status);
            }
        }
        Connections {
            target: dashboardObject
            property string oldIp
            property string skString;
            function onSendIpToQml(inputStr){
                skString = inputStr
                if (skString.indexOf("10.0") !== -1 || skString.indexOf("10.6") !== -1 || skString.indexOf("172") !== -1){
                    buttonIsVisible = true
                    backlightControl.backlightLevelChanged(30)
                }
                else{
                    buttonIsVisible = false
                }
                //console.log()
                dynamicTextRow.deleteRowFromArray(oldIp)
                dynamicTextRow.insertRowToArray(inputStr)
            }
            property string connectionLossMsg: "Нет связи по CAN шине";
            function onSendCanConnectionLoss(inputBool){
                if(inputBool){
                    dynamicTextRow.insertRowToArray(connectionLossMsg)
                }
                else{
                    dynamicTextRow.deleteRowFromArray(connectionLossMsg)
                }
            }
        }
        Connections {
            target: calculateMileage
            function onSendTotalMileageToQml(totalMileageCalc) {
                totalMileageValue.text = totalMileageCalc;
            }
            function onSendActualMileageToQml(actualMileageCalc) {
                actualMileageValue.text = actualMileageCalc;
            }
        }
        Connections  {
            target: connectionFromCpp // Указываем целевое соединение
            // Объявляем и реализуем функцию, как параметр
            // объекта и с имененем похожим на название сигнала
            // Разница в том, что добавляем в начале on и далее пишем
            // с заглавной буквы
            //
            function onSendButtonMenuStateToQml(state) {
                //console.log("menu " + state)
                if (state && menuLoader.active === false) {
                    menuLoader.active = true
                    menuLoader.setSource("qrc:/DashboardGeneral/qmlUserClass/menuItem/commonElement/mainMenu.qml", {"typeMenu": "Electro"});
                }
                if (state && menuLoader.active === true) {
                    menuLoader.active = false
                }
            }
            function onSendButtonOkStateToQml(state) {
                //console.log("menu " + state)
                if (state === 1 && menuLoader.active === false) {
                    menuLoader.active = true
                    menuLoader.setSource("qrc:/DashboardGeneral/qmlUserClass/menuItem/commonElement/mainMenu.qml", {"typeMenu": "Electro"});
                }
            }
            function onSendAddErrorCanSignalToQml(canSignalName) {
                dynamicTextRow.addCanSignalError(canSignalName);
            }
            function onSendDeleteErrorCanSignalToQml(canSignalName) {
                dynamicTextRow.deleteCanSignalError(canSignalName);
            }
            //            function onSendAddMissedCanMsgToQml(){
            //                //if (canMsgName == "ASC1_A") console.log("ASC1_A")
            //                downDynamicTextRow.addCanMsgMissedError(canMsgName);
            //            }
            //            function onSendDeleteMissedCanMsgToQml(){
            //                //if (canMsgName == "ASC1_A") console.log("not ASC1_A")
            //                downDynamicTextRow.deleteCanMsgMissedError(canMsgName);
            //            }
            function onSendTimeToQml(timeRx) {
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
            function onSendDateToQml(dateRx) {
                actualDate.date_str = dateRx;
            }
            property string translateDay1: qsTr("пн")
            property string translateDay2: qsTr("вт")
            property string translateDay3: qsTr("ср")
            property string translateDay4: qsTr("чт")
            property string translateDay5: qsTr("пт")
            property string translateDay6: qsTr("сб")
            property string translateDay7: qsTr("вс")
            function onSendWeekDayToQml(weekDayRx) {
                actualDate.weekDay_str = qsTr(weekDayRx);
            }
            //            function onSendEstimatedKmRangeToQml(){
            //                estimatedKilometersRangeValue.text = inputFloat.toFixed(0)
            //            }
        }
        //        Connections {
        //            target: canBus
        //            function onSendAddCanErrorToQml(){
        //                //console.log(error_str)
        //                dynamicTextRow.addCanBusError(error_str)
        //            }
        //            function onSendDeleteCanErrorToQml(){
        //                dynamicTextRow.deleteCanBusError(error_str)
        //            }
        //        }
        Connections {
            target: busInterior
            function onSendTempOutsideToQml(inputString) {
                tempOutsideValue.text = inputString
            }
            function onSendTempInsideToQml(inputString) {
                tempCabinValue.text = inputString
            }
            function onSendTempSalonToQml(inputString) {
                tempSalonValue.text = inputString
            }
            function onSendRampStatusToQml(inputUint) {
                if (inputUint === 2) {
                    rampState_L.source = "/DashboardGeneral/images/signalLamps/busExterior/rampSensorMalfunction.png"
                    rampState_L.lampOn()
                }
                else if (inputUint === 1) {
                    rampState_L.source = "/DashboardGeneral/images/signalLamps/busExterior/theRampIsOpen.png"
                    rampState_L.lampOn()
                    warningSound.play()
                    banner.showWarningFor5s("Выдвинута аппарель")
                }
                else{
                    rampState_L.lampOff()
                }
            }
            function onSendRearCompartmentStatusToQml(inputUint) {
                if (inputUint) {
                    warningSound.play()
                    rearCompartmentIsOpen_L.lampOn()
                    banner.showErrorFor5s("Открыт отсек двигателя!")
                }
                else rearCompartmentIsOpen_L.lampOff()
            }
            function onSendFrontCompartmentStatusToQml(inputUint) {
                if (inputUint){
                    warningSound.play()
                    frontCompartment_L.lampOn()
                }
                else frontCompartment_L.lampOff()
            }
        }
        Connections {
            target: motor
            function onSendSpeedToQml(inputFloat) {
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
            function onSendHvCurrentToQml(inputFloat) {
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
            function onSendHvVoltageToQml(inputFloat) {
                if (background.bootAnimation === false) {
                    voltageBar.updateValue(inputFloat)
                }
            }
            function onSendHvSocToQml(inputFloat) {
                if (background.bootAnimation === false) {
                    socBar.updateValue(inputFloat)
                }
            }
            function onSendEstimatedRangeToQml(inputUint){
                if (background.bootAnimation === false) {
                    estimatedKilometersRangeValue.text = inputUint
                }
            }
            function onSendBatteryStatusToQml(inputUint){
                if (background.bootAnimation === false) {
                    if (inputUint === 5){
                        batteryVoltage_L.lampOn()
                        batteryVoltage_L.source = "/DashboardGeneral/images/signalLamps/battery/batHvOn.png"
                    }
                    else if(inputUint === 6){
                        batteryVoltage_L.lampToggle()
                        batteryVoltage_L.source = "/DashboardGeneral/images/signalLamps/battery/batHvOn.png"
                    }
                    else{
                        batteryVoltage_L.lampOn()
                        batteryVoltage_L.source = "/DashboardGeneral/images/signalLamps/battery/batHvOff.png"
                    }
                }
            }
        }
        Connections {
            target: brakeSystem
            function onSendPressureCircuit1ToQml(inputFloat) {
                if (background.bootAnimation === false) {
                    brakePressureCircuit_1.updateValue(inputFloat)
                }
            }
            function onSendPressureCircuit2ToQml(inputFloat) {
                if (background.bootAnimation === false) {
                    brakePressureCircuit_2.updateValue(inputFloat)
                }
            }
            function onSendPressureCircuit1LampToQml(inputBool) {
                if (inputBool) {
                    errorSound.play()
                    brakeCircuit1_L.source = "/DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit1Failure.png"
                    dynamicTextRow.insertRowToArray("Низкое давление в контуре 1")
                }
                else {
                    brakeCircuit1_L.source = "/DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit1.png"
                    dynamicTextRow.deleteRowFromArray("Низкое давление в контуре 1")
                }
            }
            function onSendPressureCircuit2LampToQml(inputBool) {
                if (inputBool) {
                    errorSound.play()
                    brakeCircuit2_L.source = "/DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit2Failure.png"
                    dynamicTextRow.insertRowToArray("Низкое давление в контуре 2")
                }
                else {
                    brakeCircuit2_L.source = "/DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit2.png"
                    dynamicTextRow.deleteRowFromArray("Низкое давление в контуре 2")
                }
            }
        }
        Connections {
            target: menuLoader.item
            function onMenuOff(menuStateOff) {
                if (menuStateOff === true) {
                    //console.log("main")
                    menuLoader.active = false
                }
            }
        }
        Item {
            id: dials
            x: 0
            y: 0
            width: 1920
            height: 720
            visible: true
            z: 0
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
                    y: 0
                    width: 55
                    height: 40
                    color: "#ffffff"
                    text: qsTr("-17°")
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 78
                    z: 1
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Arial"
                    font.pixelSize: 35
                }

                Image {
                    id: tempOutsideIcon
                    x: 21
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
                y: 13
                width: 135
                height: 40
                Text {
                    id: tempCabinValue
                    y: 0
                    width: 70
                    height: 40
                    color: "#ffffff"
                    text: qsTr("20°")
                    anchors.left: parent.left
                    font.pixelSize: 35
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 63
                    font.family: "Arial"
                    z: 1
                }

                Image {
                    id: tempCabinIcon
                    x: 18
                    y: 0
                    width: 45
                    height: 39
                    source: "DashboardGeneral/images/driverCabin.png"
                    fillMode: Image.Stretch
                }
            }

            Item {
                id: tempSalon
                x: 1798
                y: 13
                width: 122
                height: 40
                Text {
                    id: tempSalonValue
                    y: 0
                    width: 70
                    height: 40
                    color: "#ffffff"
                    text: qsTr("24°")
                    anchors.left: parent.left
                    font.pixelSize: 35
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 40
                    font.family: "Arial"
                    z: 1
                }

                Image {
                    id: tempSalonIcon
                    x: -6
                    y: 0
                    width: 45
                    height: 39
                    source: "DashboardGeneral/images/salon.png"
                    fillMode: Image.Stretch
                }
            }

            Item {
                id: speedCover
                x: 236
                y: 249
                width: 250
                height: speedCover.width
                z: 1
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

            Item {
                id: rightCover
                x: 1430
                y: 235
                width: 250
                height: rightCover.width
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
                    x: -15
                    y: 103
                    width: 208
                    height: 60

                    Text {
                        id: estimatedKilometersRangeValue
                        x: 0
                        y: 2
                        width: 110
                        height: 60
                        color: "#ffffff"
                        text: "120"
                        font.family: "Arial"
                        font.pixelSize: 60
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                    }

                    Image {

                        id: estimatedRangeImage
                        x: 106
                        y: -13
                        width: 134
                        height: 87
                        fillMode: Image.PreserveAspectFit
                        source: "DashboardGeneral/images/estimatedRangeElectro.png"
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

                Text {
                    id: socValue
                    x: 61
                    y: 45
                    width: 110
                    height: 60
                    color: "#ffffff"
                    text: "100 %"
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
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

            SignalLamp_C {
                id: brakeCircuit1_L
                x: 25
                y: 79
                width: 60
                height: brakeCircuit1_L.width
                visible: true
                source: "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit1.png"
                fillMode: Image.PreserveAspectFit
            }

            SignalLamp_C {
                id: brakeCircuit2_L
                x: 25
                y: 600
                width: 60
                height: brakeCircuit2_L.width
                visible: true
                source: "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit2.png"
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


