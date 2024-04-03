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
        width: signalLamps.width
        height: signalLamps.height
        opacity: 0.6
        visible: true
        z: -1
        fillMode: Image.PreserveAspectFit
        source: "DashboardGeneral/images/signalLampFont_LiazNG.png"
    }


    Rectangle {
        id: shiftSelector
        x: 924
        y: 83
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
                    doorValve_L.source = "DashboardGeneral/images/fireExtinguishersAndTaps/valveOpenCapOpen.png"
                    doorValve_L.lampOn()
                }
                else if (inputUint === 1) {
                    doorValve_L.source = "DashboardGeneral/images/fireExtinguishersAndTaps/valveCloseCapOpen.png"
                    doorValve_L.lampOn()
                }
                else {
                    doorValve_L.lampOff()
                }
            }
            onSendRampErrorToQml:{
                if (inputUint === 2) rampError_L.lampOn()
                else rampError_L.lampOff()
            }
        }
        Connections{
            target: driverCabin
            onSendWindshieldHeatingStatusToQml:{
                if (inputUint) electricHeatedWindShield_L.lampOn()
                else electricHeatedWindShield_L.lampOff()
            }
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
                // yellow = 1,
                //red = 2,
                if (inputUint === 1) {
                    motorFailure_L.source = "DashboardGeneral/images/signalLamps/motorSystem/motorWarning.png"
                    motorFailure_L.lampOn()
                    warningSound.play()
                }
                else if (inputUint === 2) {
                    motorFailure_L.source = "DashboardGeneral/images/signalLamps/motorSystem/motorFailure.png"
                    motorFailure_L.lampOn()
                    //errorSound.play()
                }
                else if (inputUint === 4) {
                    motorFailure_L.source = "DashboardGeneral/images/signalLamps/motorSystem/motorFailure.png"
                    motorFailure_L.lampToggle()
                    //errorSound.play()
                }
                else {
                    motorFailure_L.lampOff()
                }
            }
            onSendWaterInFuelToQml: {
                if (inputUint === 1) {
                    waterInFuel_L.lampOn()
                }
                else{
                    waterInFuel_L.lampOff()
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

            onSendAirFilterDirtyToQml:{
                if (inputUint === 1) {
                    airFilter_L.lampOn()
                }
                else{
                    airFilter_L.lampOff()
                }
            }
            onSendLowOilPressureToQml:{
                if (inputUint === 1) {
                    oil_L.lampOn()
                }
                else{
                    oil_L.lampOff()
                }
            }
            onSendHeatingInsideAirToQml:{
                if (inputUint === 1) {
                    inputAirHeat_L.lampOn()
                }
                else{
                    inputAirHeat_L.lampOff()
                }
            }
            onSendLowUreaToQml:{
                //console.log(inputUint)
                if (inputUint === 1) {
                    lowUrea_L.lampOn()
                }
                else{
                    lowUrea_L.lampOff()
                }
            }
            onSendExhaustErrorToQml:{
                if (inputUint === 1) {
                    exhaust_L.lampOn()
                }
                else{
                    exhaust_L.lampOff()
                }
            }
            onSendAutoTransOverheatingToQml:{
                if (inputUint === 1) {
                    agbOverheat_L.lampOn()
                }
                else{
                    agbOverheat_L.lampOff()
                }
            }
            onSendAutoTransErrorToQml:{
                if (inputUint === 1) {
                    agbFail_L.lampOn()
                }
                else{
                    agbFail_L.lampOff()
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
                    autokneelingStatus_L.lampOff()
                }
                else if (inputUint === 1) {
                    kneelingStatus_L.lampOn()
                    autokneelingStatus_L.lampOff()
                }
                else if (inputUint === 2) {
                    autokneelingStatus_L.lampOn()
                    kneelingStatus_L.lampOff()
                }
                else {
                    autokneelingStatus_L.lampOff()
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
                    turnSignals.turnSignalRightSetState(true)
                }
                else{
                    turnSignals.turnSignalRightSetState(false)
                }
            }
            onSendLeftTurnSignalLightToQml: {
                if (inputUint === 1){
                    turnSignals.turnSignalLeftSetState(true)
                }
                else {
                    turnSignals.turnSignalLeftSetState(false)
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
        x: 676
        y: 93
        width: 75
        height: markerLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/markerLights.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: pumpWork_L
        x: 1436
        y: 468
        width: 50
        height: pumpWork_L.width
        source: "DashboardGeneral/images/signalLamps/busInterior/liquidHeater.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: motorFailure_L
        x: 274
        y: 225
        width: 60
        height: 42
        source: "DashboardGeneral/images/signalLamps/motorSystem/motorWarning.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: wornBrakeLinings_L
        x: 1437
        y: 225
        width: 55
        height: wornBrakeLinings_L.width
        visible: false
        source: "DashboardGeneral/images/signalLamps/brakeSystem/wornBrakeLinings.png"
        //test: signalLampTest
        test: signalLampTest
    }

    SignalLamp_C {
        id: lowTirePressure_L
        x: 354
        y: 200
        width: 45
        height: lowTirePressure_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/brakeSystem/lowTyrePressure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: battery24v_L
        x: 1259
        y: 516
        width: 55
        height: battery24v_L.width
        source: "DashboardGeneral/images/signalLamps/battery24v.png"
        visible: true
        property bool lowVoltageStartSound: false

        Text {
            id: battery24Voltage_T
            x: 8
            y: 22
            width: 42
            height: 17
            color: "#ffffff"
            text: qsTr("--")
            font.family: "Arial"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
        }
    }

    SignalLamp_C {
        id: frontFogLights_L
        x: 840
        y: 97
        width: 57
        height: frontFogLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/frontFogLight.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: highBeamHeadLights_L
        x: 1199
        y: 97
        width: 57
        height: highBeamHeadLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/highBeamHeadLights.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: lowBeamHeadLights_L
        x: 1117
        y: 98
        width: 57
        height: lowBeamHeadLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/lowBeamHeadLights.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: rearFogLight_L
        x: 771
        y: 97
        width: 57
        height: rearFogLight_L.width
        source: "DashboardGeneral/images/signalLamps/lights/rearFogLight.png"
        test: signalLampTest
    }
    TurnSignals_C {
        id: turnSignals
        y: 96
        width: 762
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
        x: 1242
        y: 231
        width: 55
        height: suspensionStatus_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/suspension/heightControlNotNormal.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: autokneelingStatus_L
        x: 1312
        y: 182
        width: 45
        height: autokneelingStatus_L.width
        visible: false
        source: "DashboardGeneral/images/signalLamps/suspension/autoKneeling.png"
        test: signalLampTest
    }
    SignalLamp_C {
        id: runningLights_L
        x: 1031
        y: 95
        width: 58
        height: runningLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/runningLights.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: lowCoolantEngineLevel_L
        x: 1242
        y: 177
        width: 55
        height: lowCoolantEngineLevel_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/motorSystem/engineCoolantLowLevel.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: parkingBrake_L
        x: 1634
        y: 274
        width: 60
        height: parkingBrake_L.width
        source: "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuitParkBrakeFailure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: interiorLighting_L
        x: 1180
        y: 175
        width: 50
        height: interiorLighting_L.width
        source: "DashboardGeneral/images/signalLamps/busInterior/interiorCompartmentIllumination.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
        Text {
            id: interiorLighting_T
            x: 3
            y: 37
            width: 50
            height: 17
            color: "#ffff00"
            text: qsTr("21%")
            font.family: "Arial"
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 17
        }
    }

    SignalLamp_C {
        id: disablePersonRequest_L
        x: 673
        y: 184
        width: 44
        height: disablePersonRequest_L.width
        source: "DashboardGeneral/images/signalLamps/disabledPersonRequest.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: ebsState_L
        x: 1641
        y: 412
        width: 56
        height: ebsState_L.width
        source: "DashboardGeneral/images/signalLamps/brakeSystem/EBS_Red.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: pumpFail_L
        x: 1515
        y: 486
        width: 54
        height: pumpFail_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/busInterior/pumpFail.png"
        test: signalLampTest
        fillMode: Image.PreserveAspectFit
    }

    SignalLamp_C {
        id: hammer_L
        x: 1154
        y: 520
        width: 45
        height: hammer_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/busInterior/hammer.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: kneelingStatus_L
        x: 1302
        y: 175
        width: 55
        height: kneelingStatus_L.width
        source: "DashboardGeneral/images/signalLamps/suspension/kneeling.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: seatBeltSwitch_L
        x: 723
        y: 183
        width: 44
        height: seatBeltSwitch_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/busCabin/seatBeltNotFastened.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: electricHeatedWindShield_L
        x: 998
        y: 171
        width: 70
        height: electricHeatedWindShield_L.width
        source: "DashboardGeneral/images/signalLamps/windshield/windshieldHeating.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: asr_L
        x: 574
        y: 522
        width: 44
        height: asr_L.width
        source: "DashboardGeneral/images/signalLamps/brakeSystem/ESC_On.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: washerFluidLevel_L
        x: 1100
        y: 522
        width: 48
        height: washerFluidLevel_L.width
        source: "DashboardGeneral/images/signalLamps/windshield/windshielFluidLevelWarning.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: wipers_L
        x: 1077
        y: 181
        width: 37
        height: wipers_L.width
        source: "DashboardGeneral/images/signalLamps/windshield/windshield_delayed.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: mirrorHeating_L
        x: 937
        y: 523
        width: 44
        height: mirrorHeating_L.width
        source: "DashboardGeneral/images/signalLamps/busCabin/mirrorHeating.png"
        mirror: false
        test: signalLampTest
    }

    SignalLamp_C {
        id: waterInFuel_L
        x: 810
        y: 521
        width: 55
        height: waterInFuel_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/motorSystem/waterInFuel.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: lowUrea_L
        x: 1326
        y: 523
        width: 43
        height: lowUrea_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/motorSystem/lowUrea.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: airFilter_L
        x: 744
        y: 517
        width: 55
        height: airFilter_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/motorSystem/airFilterWarning.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: exhaust_L
        x: 876
        y: 516
        width: 55
        height: exhaust_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/motorSystem/warningExhaust.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: oil_L
        x: 675
        y: 518
        width: 60
        height: oil_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/motorSystem/lowOil.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: agbFail_L
        x: 831
        y: 182
        width: 45
        height: agbFail_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/motorSystem/failureAGB.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: agbOverheat_L
        x: 882
        y: 182
        width: 45
        height: agbOverheat_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/motorSystem/overheatAGB.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: route_L
        x: 1130
        y: 182
        width: 45
        height: route_L.width
        visible: false
        source: "DashboardGeneral/images/signalLamps/route.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: retarder_L
        x: 933
        y: 178
        width: 55
        height: retarder_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/motorSystem/retarder.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: inputAirHeat_L
        x: 1389
        y: 417
        width: 56
        height: inputAirHeat_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/motorSystem/inputAirHeating.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: airBrake3_L
        x: 1515
        y: 196
        width: 55
        height: airBrake3_L.width
        source: "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit3Failure.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: airBrake4_L
        x: 1594
        y: 224
        width: 55
        height: airBrake4_L.width
        source: "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit4Failure.png"
        test: signalLampTest
        fillMode: Image.PreserveAspectFit
    }

    SignalLamp_C {
        id: fireExting_L
        x: 1211
        y: 520
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
        x: 777
        y: 182
        width: 44
        height: noDriver_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/busCabin/noDriverInTheSeat.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: doorValve_L
        x: 521
        y: 522
        width: 44
        height: doorValve_L.width
        source: "DashboardGeneral/images/fireExtinguishersAndTaps/valveCloseCapOpen.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: rampError_L
        x: 625
        y: 185
        width: 40
        height: rampError_L.width
        source: "DashboardGeneral/images/signalLamps/rampError.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: seatHeating_L
        x: 1047
        y: 526
        width: 40
        height: width
        source: "DashboardGeneral/images/signalLamps/busCabin/seatHeating.png"
        test: signalLampTest
    }
}
