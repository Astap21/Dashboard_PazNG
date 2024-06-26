import QtQuick 2.9
import QtQuick.Window 2.3
import QtQml 2.5
import "DashboardGeneral/qmlUserClass"
import "DashboardGeneral/qmlUserClass/baseClasses"

Item {
    id: signalLamps
    width: 1920
    height: 720
    property int imageWidth: 100
    property bool signalLampTest: true

    Image {
        id: signalLamps_font
        x: 1
        y: 0
        width: signalLamps.width
        height: signalLamps.height
        opacity: 0.6
        visible: true
        z: -1
        fillMode: Image.PreserveAspectFit
        source: "img/signalLamps_font_PazNG.jpg"
    }


    Rectangle {
        id: shiftSelector
        x: 921
        y: 136
        width: 78
        height: 78
        color: "#00000000"
        radius: 5
        border.width: 2
        border.color: "#ffffff"

        Text {
            id: shiftSelectorText
            x: 0
            y: 0
            width: 78
            height: 78
            color: "#ffffff"
            text: "N"
            anchors.verticalCenterOffset: 2
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Arial"
            font.pixelSize: 75
        }
    }
    Connections{
            target: busInterior
            onSendBattery24VoltageToQml: {
                if (inputFloat <= 24) {
                    battery24v_L.source = "DashboardGeneral/images/signalLamps/battery24vFailure.png"
                }
                else {
                    battery24v_L.source = "DashboardGeneral/images/signalLamps/battery24v.png"
                }
                battery24Voltage_T.text = inputFloat.toFixed(1)
            }
            onSendRequestDisablePersonToQml: {
                if (inputUint) {
                    warningSound.play()
                    disablePersonRequest_L.lampOn()
                }
                else disablePersonRequest_L.lampOff()
            }
            onSendInteriorLightingToQml: {
                if (inputUint !== 0 ) {
                    interiorLighting_L.lampOn()
                    interiorLighting_T.text = inputUint + "%"
                }
                else interiorLighting_L.lampOff()

            }
            onSendLiquidHeaterToQml:{
                if (inputUint) pumpWork_L.lampOn()
                else pumpWork_L.lampOff()
            }
            onSendHammerStatusToQml:{
                if (inputUint) hammer_L.lampOn()
                else hammer_L.lampOff()
            }
            onSendFireExtingStatusToQml:{
                if (inputUint) fireExting_L.lampOn()
                else fireExting_L.lampOff()
            }
            onSendDoorValveToQml:{
                if (inputUint === 2) {
                    door2Valve_L.source = "DashboardGeneral/images/fireExtinguishersAndTaps/valveOpenCapOpen.png"
                    door2Valve_L.lampOn()
                }
                else if (inputUint === 1) {
                    door2Valve_L.source = "DashboardGeneral/images/fireExtinguishersAndTaps/valveCloseCapOpen.png"
                    door2Valve_L.lampOn()
                }
                else {
                    door2Valve_L.lampOff()
                }
            }
            onSendRampErrorToQml:{
                if (inputUint === 2) rampError_L.lampOn()
                else rampError_L.lampOff()
            }
        }
        Connections{
            target: driverCabin
            onSendElecticHeatedSideWindowsStatusToQml:{
//                if (inputUint) asr_L.lampOn()
//                else asr_L.lampOff()
            }
            onSendSeatHeatingStatusToQml:{
                if (inputUint) seatHeating_L.lampOn()
                else seatHeating_L.lampOff()
            }

            onSendHeaterMirrorsStatusToQml:{
                //console.log(inputUint)
                if (inputUint === 1) mirrorHeating_L.lampOn()
                else if (inputUint === 2) mirrorHeating_L.lampOn()
                else mirrorHeating_L.lampOff()
            }
            onSendWasherFluidLampToQml:{
                if (inputUint) {
                    washerFluidLevel_L.lampOn()
                    //warningSound.play()
                }
                else washerFluidLevel_L.lampOff()
            }
            onSendPowerSteeringStatusToQml: {
                //console.log(inputUint)
                if (inputUint === 1) {
                    steeringOff_L.source = "DashboardGeneral/images/signalLamps/busCabin/steeringOff.png"
                    //steeringOff_L.lampOn()
                }
                else if (inputUint === 2) {
                    steeringOff_L.source = "DashboardGeneral/images/signalLamps/busCabin/steeringFailure.png"
                    //steeringOff_L.lampOn()
                }
                //else steeringOff_L.lampOff()
            }
            onSendWipersStatusToQml:{
                if (inputUint !== 0) wipers_L.lampOn()
                else wipers_L.lampOff()

                if (inputUint === 1) wipers_L.source = "DashboardGeneral/images/signalLamps/windshield/windshield_1.png"
                if (inputUint === 2) wipers_L.source = "DashboardGeneral/images/signalLamps/windshield/windshield_2.png"
                if (inputUint === 4) wipers_L.source = "DashboardGeneral/images/signalLamps/windshield/windshield_delayed.png"
                if (inputUint === 7) wipers_L.source= "DashboardGeneral/images/signalLamps/windshield/windshieldAuto.png"
            }
            onSendOperatorSeatDirectionSwitchToQml:{
                if (inputUint === 1) noDriver_L.lampOn()
                else noDriver_L.lampOff()
            }

            onSendSeatBeltSwitchToQml:{
                if (inputUint === 1) seatBeltSwitch_L.lampOn()
                else seatBeltSwitch_L.lampOff()
            }
        }
        Connections {
            target: motor
            onSendActualGearToQml: {
                shiftSelectorText.text = inputString;
            }
            onSendEngineLowCoolantLevelToQml: {
                //console.log("inputBool");
                if (inputBool) {
                    //errorSound.play()
                    lowCoolantEngineLevel_L.lampOn();
                }
                else lowCoolantEngineLevel_L.lampOff();
            }
            onSendOverheatMotorToQml: {
    //            if (inputBool) {
    //                errorSound.play()
    //                overheatMotor_L.lampOn()
    //            }
    //            else overheatMotor_L.lampOff()
            }
            onSendEngineLampToQml: {
                if (inputUint === 2){
                    motorError_L.source = "DashboardGeneral/images/signalLamps/motorSystem/electricMotorFailure.png"
                }
                else if (inputUint === 1) {
                    //errorSound.play()
                    motorError_L.lampOn()
                    motorError_L.source = "DashboardGeneral/images/signalLamps/motorSystem/electricMotorWarning.png"
                }
                else {
                    motorError_L.lampOff()
                }
            }
            onSendBatteryStatusToQml:{
                if(inputUint === 2){
                    hvBatError_L.lampOn()
                }
                else{
                    hvBatError_L.lampOff()
                }
            }

            onSendCirculationPumpToQml: {
                if (inputUint === 2) {
                    pumpFail_L.lampOn()
                    pumpWork_L.lampOff()
                }
                else if (inputUint === 3) {
                    pumpWork_L.lampOn()
                    pumpFail_L.lampOff()
                }
                else{
                    pumpWork_L.lampOff()
                    pumpFail_L.lampOff()
                }
            }
            onSend_tmsErrorToQml:{
                if(inputUint !== 0){
                    tmsError_L.lampOn()
                }
                else{
                    tmsError_L.lampOff()
                }
                if (inputUint === 12){
                    tmsWarning_L.lampOn()
                }
                else{
                    tmsWarning_L.lampOff()
                }
            }
//            onSend_tmsOnToQml:{
//                if(inputUint === 2){
//                    tmsHeating_L.lampOn()
//                }
//                else{
//                    tmsHeating_L.lampOff()
//                }
//            }
            onSend_motorStatusToQml:{
                if(inputUint === 1){
                    motorError_L.lampOn()
                    motorError_L.source = "DashboardGeneral/images/signalLamps/motorSystem/electricMotorWarning.png"
                }
                else if(inputUint === 2){
                    motorError_L.lampOn()
                    motorError_L.source = "DashboardGeneral/images/signalLamps/motorSystem/electricMotorFailure.png"
                }
                else{
                    motorError_L.lampOff()
                }
            }
            onSend_steeringWheelToQml:{
                if(inputUint === 1){
                    steering_L.lampOn()
                    steering_L.source = "DashboardGeneral/images/signalLamps/steeringOff.png"
                }
                else if(inputUint === 2){
                    steering_L.lampOn()
                    steering_L.source = "DashboardGeneral/images/signalLamps/steeringFailure.png"
                }
                else{
                    steering_L.lampOff()
                }
            }
            onSend_batteryHeatingToQml:{
                if(inputUint === 2){
                    tmsHeating_L.lampOn()
                }
                else{
                    tmsHeating_L.lampOff()
                }
            }
            onSend_externalCordToQml:{
                if(inputUint === 1){
                    externalCord_L.lampOn()
                }
                else{
                    externalCord_L.lampOff()
                }
            }
            onSend_isolationToQml:{
                if(inputUint === 1){
                    isolation_L.lampOn()
                    isolation_L.source = "DashboardGeneral/images/signalLamps/battery/insulationControlWarning.png"
                }
                else if(inputUint === 2){
                    isolation_L.lampOn()
                    isolation_L.source = "DashboardGeneral/images/signalLamps/battery/insulationControlFailure.png"
                }
                else if(inputUint === 3){
                    isolation_L.lampOn()
                    isolation_L.source = "DashboardGeneral/images/signalLamps/battery/insulationControlOk.png"
                }
                else{
                    isolation_L.lampOff()
                }
            }
        }
        Connections{
            target: suspension
            onSendSuspensionStatusToQml: {
                //console.log(inputUint)
                if (inputUint === 0){
                    suspensionStatus_L.lampOff()
                }
                else if(inputUint === 1){
                    suspensionStatus_L.lampOn()
                    suspensionStatus_L.source = "DashboardGeneral/images/signalLamps/suspension/heightControlNotNormal.png"
                }
                else if(inputUint === 2){
                    suspensionStatus_L.lampOn()
                    suspensionStatus_L.source = "DashboardGeneral/images/signalLamps/suspension/heightIncrease.png"
                }
                else if(inputUint === 3){
                    suspensionStatus_L.lampToggle()
                    suspensionStatus_L.source = "DashboardGeneral/images/signalLamps/suspension/heightIncrease.png"
                }
                else if(inputUint === 4){
                    suspensionStatus_L.lampOn()
                    suspensionStatus_L.source = "DashboardGeneral/images/signalLamps/suspension/heightDecrease.png"
                }
                else if(inputUint === 5){
                    suspensionStatus_L.lampToggle()
                    suspensionStatus_L.source = "DashboardGeneral/images/signalLamps/suspension/heightDecrease.png"
                }
            }
            onSendSuspensionErrorToQml:{
                if (inputUint === 1){
                    //suspensionError_L.lampOn()
                    suspensionError_L.source = "DashboardGeneral/images/signalLamps/suspension/heightControlNotNormal.png"
                }
                else if (inputUint === 2){
                    //suspensionError_L.lampOn()
                    suspensionError_L.source = "DashboardGeneral/images/signalLamps/suspension/suspensionError.png"
                }
                //else suspensionError_L.lampOff()
            }
            onSendKneelingStatusToQml: {
                if (inputUint === 2) {
                    kneelingStatus_L.lampToggle()
                    //autokneelingStatus_L.lampOff()
                }
                else if (inputUint === 1) {
                    kneelingStatus_L.lampOn()
                    //autokneelingStatus_L.lampOff()
                }
                else if (inputUint === 2) {
                    //autokneelingStatus_L.lampOn()
                    kneelingStatus_L.lampOff()
                }
                else {
                    //autokneelingStatus_L.lampOff()
                    kneelingStatus_L.lampOff()
                }
            }
            onSendAutoKneelingStatusToQml: {
    //            if (inputBool) autokneelingStatus_L.lampOn()
    //            else autokneelingStatus_L.lampOff()
            }
        }
        Connections {
            target: exteriorLightning
            onSendRightTurnSignalLightToQml: {
                if (inputUint === 1){
                    turnSignals.turnRightOn()
                }
                else{
                    turnSignals.turnRightOff()
                }
            }
            onSendLeftTurnSignalLightToQml: {
                if (inputUint === 1){
                    turnSignals.turnLeftOn()
                }
                else {
                    turnSignals.turnLeftOff()
                }
            }
            onSendMarkerLightsToQml:{
                if (inputUint) markerLights_L.lampOn()
                else markerLights_L.lampOff()
            }
            onSendRearFogLightsToQml:{
                if (inputUint) rearFogLight_L.lampOn()
                else rearFogLight_L.lampOff()
            }
            onSendFrontFogLightsToQml:{
                if (inputUint) frontFogLights_L.lampOn()
                else frontFogLights_L.lampOff()
            }
            onSendLowBeamHeadLightsToQml:{
                if (inputUint) lowBeamHeadLights_L.lampOn()
                else lowBeamHeadLights_L.lampOff()
            }
            onSendHighBeamHeadLightsToQml:{
                if (inputUint) highBeamHeadLights_L.lampOn()
                else highBeamHeadLights_L.lampOff()
            }
            onSendRunningLightsToQml:{
                if (inputUint) runningLights_L.lampOn()
                else runningLights_L.lampOff()
            }
        }


        Connections {
            target: brakeSystem
            onSendASR_IndicationToQml:{
                if (inputUint) asr_L.lampOn()
                else asr_L.lampOff()
            }
            onSendPressureCircuitParkBrakeToQml:{
                if (inputUint === 1) {
                    parkingBrake_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuitParkBrakeFailure.png"
                    parkingBrake_L.lampOn()
                }
                else if (inputUint === 2){
                    //errorSound.play()
                    parkingBrake_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuitParkBrakeFailure.png"
                    parkingBrake_L.lampToggle()
                }
                else if (inputUint === 3){
                    //errorSound.play()
                    parkingBrake_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/autoHold.png"
                    parkingBrake_L.lampOn()
                }
                else if (inputUint === 4){
                    //errorSound.play()
                    parkingBrake_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/errorEPB.png"
                    parkingBrake_L.lampOn()
                }
                else parkingBrake_L.lampOff()
            }
            onSendEBS_IndicationToQml:{
                //console.log(inputUint)
                if (inputUint === 0) {
                    ebsState_L.lampOff()
                } else if (inputUint === 1) {
                    ebsState_L.lampOn()
                    ebsState_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/EBS_Yellow.png"
                } else if (inputUint === 2) {
                    ebsState_L.lampOn()
                    ebsState_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/EBS_Red.png"
                }
                else if (inputUint === 3) {
                    //errorSound.play()
                    pwm.playSound(0)
                    ebsState_L.lampToggle()
                    ebsState_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/EBS_Red.png"
                }

            }
            onSendESC_IndicationToQml:{
                if (inputUint === 0) {
                    pumpFail_L.lampOff()
                } else if (indicationState === 1) {
                    pumpFail_L.lampToggle()
                    pumpFail_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/ESC_On.png"
                } else if (inputUint === 2) {
                    pumpFail_L.lampOn()
                    pumpFail_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/ESC_On.png"
                }
                else if (inputUint === 3) {
                    pumpFail_L.lampOn()
                    pumpFail_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/ESC_Off.png"
                }
            }
            onSendHillHolderIndicationToQml:{
                //console.log(indicationState)
                if (inputUint === 0) {
                    //hillHolder_L.lampOff()
                } else if (inputUint === 1) {
                    hillHolder_L.lampOn()
                } else if (inputUint === 2) {
                    hillHolder_L.togglingPeriod = 500
                    //hillHolder_L.lampToggle()
                }
                else if (inputUint === 3) {
                    hillHolder_L.togglingPeriod = 200
                    //hillHolder_L.lampToggle()
                }

            }
            onSendHaltBrakeStatusToQml:{
    //            if (inputBool) haltBrake_L.lampOn()
    //            else haltBrake_L.lampOff()
            }
            onSendLowBrakePadsToQml:{
                if (inputBool) {
                    //warningSound.play()
                    wornBrakeLinings_L.lampOn()
                }
                else wornBrakeLinings_L.lampOff()
            }
            onSendPressureCircuit3LampToQml: {
                if (inputBool) {
                    //errorSound.play()
                    airBrake3_L.visible = true;
                    airBrake3_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit3Failure.png"
                }
                else airBrake3_L.visible = false
            }
            onSendPressureCircuit4LampToQml: {
                if (inputBool) {
                    //errorSound.play()
                    airBrake4_L.visible = true;
                    airBrake4_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit4Failure.png"
                }
                else airBrake4_L.visible = false
            }
            onSendRetarderPercentToQml:{
                if(inputFloat > 0){
                    retarder_L.lampOn()
                }
                else {
                    retarder_L.lampOff()
                }
            }
            onSendLowTirePressureToQml:{
                if (inputBool){
                    lowTirePressure_L.lampOn()
                }
                else {
                    lowTirePressure_L.lampOff()
                }
            }
        }


    SignalLamp_C {
        id: markerLights_L
        x: 645
        y: 1
        width: 75
        height: markerLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/markerLights.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: pumpWork_L
        x: 1438
        y: 471
        width: 50
        height: pumpWork_L.width
        source: "DashboardGeneral/images/signalLamps/busInterior/liquidHeater.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: wornBrakeLinings_L
        x: 1430
        y: 222
        width: 55
        height: wornBrakeLinings_L.width
        visible: false
        source: "DashboardGeneral/images/signalLamps/brakeSystem/wornBrakeLinings.png"
        //test: signalLampTest
        test: signalLampTest
    }

    SignalLamp_C {
        id: lowTirePressure_L
        x: 1379
        y: 284
        width: 45
        height: lowTirePressure_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/brakeSystem/lowTyrePressure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: battery24v_L
        x: 556
        y: 85
        width: 50
        height: battery24v_L.width
        source: "DashboardGeneral/images/signalLamps/battery24v.png"
        visible: true
        property bool lowVoltageStartSound: false

        Text {
            id: battery24Voltage_T
            width: 42
            height: 17
            color: "#ffffff"
            text: qsTr("--")
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Arial"
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
        }
    }

    SignalLamp_C {
        id: frontFogLights_L
        x: 842
        y: 10
        width: 57
        height: frontFogLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/frontFogLight.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: highBeamHeadLights_L
        x: 1221
        y: 14
        width: 57
        height: highBeamHeadLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/highBeamHeadLights.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: lowBeamHeadLights_L
        x: 1123
        y: 12
        width: 57
        height: lowBeamHeadLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/lowBeamHeadLights.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: rearFogLight_L
        x: 755
        y: 9
        width: 57
        height: rearFogLight_L.width
        source: "DashboardGeneral/images/signalLamps/lights/rearFogLight.png"
        test: signalLampTest
    }
    TurnSignals_C {
        id: turnSignals
        y: 10
        width: 829
        height: 60
        anchors.horizontalCenterOffset: 1
        togglingPeriod: 500
        anchors.horizontalCenter: parent.horizontalCenter
        distanceBetweenImages: 100
    }

    SignalLamp_C {
        id: exteriorBulbFailure_L
        x: 568
        y: 183
        width: 46
        height: exteriorBulbFailure_L.width
        visible: false
        source: "DashboardGeneral/images/signalLamps/lights/exteriorBulbFailure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: suspensionStatus_L
        x: 1020
        y: 139
        width: 55
        height: suspensionStatus_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/suspension/heightControlNotNormal.png"
        test: signalLampTest
    }
    SignalLamp_C {
        id: runningLights_L
        x: 1024
        y: 10
        width: 58
        height: runningLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/runningLights.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: lowCoolantEngineLevel_L
        x: 1091
        y: 80
        width: 55
        height: lowCoolantEngineLevel_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/motorSystem/engineCoolantLowLevel.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: parkingBrake_L
        x: 1642
        y: 277
        width: 60
        height: parkingBrake_L.width
        source: "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuitParkBrakeFailure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: interiorLighting_L
        x: 918
        y: 523
        width: 47
        height: interiorLighting_L.width
        source: "DashboardGeneral/images/signalLamps/busInterior/interiorCompartmentIllumination.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
        Text {
            id: interiorLighting_T
            x: 2
            y: 34
            width: 50
            height: 17
            color: "#ffff00"
            text: qsTr("25%")
            font.family: "Arial"
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 17
        }
    }

    SignalLamp_C {
        id: disablePersonRequest_L
        x: 939
        y: 370
        width: 50
        height: disablePersonRequest_L.width
        source: "DashboardGeneral/images/signalLamps/disabledPersonRequest.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: ebsState_L
        x: 1645
        y: 410
        width: 56
        height: ebsState_L.width
        source: "DashboardGeneral/images/signalLamps/brakeSystem/EBS_Red.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: pumpFail_L
        x: 1517
        y: 504
        width: 50
        height: pumpFail_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/busInterior/pumpFail.png"
        test: signalLampTest
        fillMode: Image.PreserveAspectFit
    }

    SignalLamp_C {
        id: hammer_L
        x: 1151
        y: 530
        width: 45
        height: hammer_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/busInterior/hammer.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: kneelingStatus_L
        x: 1094
        y: 141
        width: 55
        height: kneelingStatus_L.width
        source: "DashboardGeneral/images/signalLamps/suspension/kneeling.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: seatBeltSwitch_L
        x: 1246
        y: 530
        width: 44
        height: seatBeltSwitch_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/busCabin/seatBeltNotFastened.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: asr_L
        x: 518
        y: 530
        width: 44
        height: asr_L.width
        source: "DashboardGeneral/images/signalLamps/brakeSystem/ESC_On.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: washerFluidLevel_L
        x: 1094
        y: 527
        width: 48
        height: washerFluidLevel_L.width
        source: "DashboardGeneral/images/signalLamps/windshield/windshielFluidLevelWarning.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: wipers_L
        x: 742
        y: 526
        width: 45
        height: wipers_L.width
        source: "DashboardGeneral/images/signalLamps/windshield/windshield_delayed.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: mirrorHeating_L
        x: 799
        y: 530
        width: 44
        height: mirrorHeating_L.width
        source: "DashboardGeneral/images/signalLamps/busCabin/mirrorHeating.png"
        mirror: false
        test: signalLampTest
    }

    SignalLamp_C {
        id: route_L
        x: 680
        y: 531
        width: 45
        height: route_L.width
        visible: false
        source: "DashboardGeneral/images/signalLamps/route.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: airBrake3_L
        x: 1514
        y: 191
        width: 55
        height: airBrake3_L.width
        source: "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit3Failure.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: airBrake4_L
        x: 1598
        y: 221
        width: 55
        height: airBrake4_L.width
        source: "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit4Failure.png"
        test: signalLampTest
        fillMode: Image.PreserveAspectFit
    }

    SignalLamp_C {
        id: fireExting_L
        x: 1202
        y: 531
        width: 45
        height: width
        visible: true
        source: "DashboardGeneral/images/fireExtinguishersAndTaps/fireExtinguisherRed.png"
        fillMode: Image.PreserveAspectFit
        autoTransform: true
        test: signalLampTest
    }

    SignalLamp_C {
        id: noDriver_L
        x: 1301
        y: 530
        width: 44
        height: noDriver_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/busCabin/noDriverInTheSeat.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: door2Valve_L
        x: 799
        y: 345
        width: 44
        height: door2Valve_L.width
        source: "DashboardGeneral/images/fireExtinguishersAndTaps/valveCloseCapOpen.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: rampError_L
        x: 1362
        y: 532
        width: 40
        height: rampError_L.width
        source: "DashboardGeneral/images/signalLamps/rampError.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: seatHeating_L
        x: 627
        y: 534
        width: 40
        height: width
        source: "DashboardGeneral/images/signalLamps/busCabin/seatHeating.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: door1Valve_L
        x: 1000
        y: 345
        width: 44
        height: 44
        source: "DashboardGeneral/images/fireExtinguishersAndTaps/valveCloseCapOpen.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: hvBatError_L
        x: 803
        y: 81
        width: 50
        height: width
        source: "DashboardGeneral/images/signalLamps/battery/batHvFail.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: motorError_L
        x: 864
        y: 83
        width: 50
        height: width
        source: "DashboardGeneral/images/signalLamps/motorSystem/electricMotorFailure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: tmsError_L
        x: 680
        y: 75
        width: 55
        height: width
        source: "DashboardGeneral/images/signalLamps/battery/tmsFailure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: steering_L
        x: 621
        y: 84
        width: 50
        height: width
        source: "DashboardGeneral/images/signalLamps/steeringFailure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: tmsWarning_L
        x: 680
        y: 136
        width: 55
        height: width
        source: "DashboardGeneral/images/signalLamps/battery/tmsCoolantLowLevel.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: externalCord_L
        x: 1214
        y: 87
        width: 50
        height: externalCord_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/battery/externalCordConnect.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: isolation_L
        x: 1156
        y: 84
        width: 50
        height: isolation_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/battery/insulationControlWarning.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: tmsHeating_L
        x: 1384
        y: 412
        width: 55
        height: width
        source: "DashboardGeneral/images/signalLamps/battery/tmsOn.png"
        test: signalLampTest
    }
}
