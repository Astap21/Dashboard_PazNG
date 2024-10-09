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
        x: 0
        y: 0
        width: signalLamps.width
        height: signalLamps.height
        opacity: 0.6
        visible: true
        z: -1
        fillMode: Image.PreserveAspectFit
        source: "img/signalLampsFontPazNg_v2.png"
    }
    ShiftSelector_C {
        id: shiftSelector
        x: 918
        y: 92
        width: 92
        height: 64
    }
    Connections{
            target: busInterior
            function onSendError24VToQml(inputUint){
                battery24v_L.errorLamp = inputUint
            }
            function onSendBattery24VoltageToQml(inputFloat) {
                if (battery24v_L.errorLamp == 2){
                    battery24v_L.lampToggle()()
                }
                else{
                    battery24v_L.lampOn()
                }
                if (inputFloat <= 24 || battery24v_L.errorLamp == 1) {
                    battery24v_L.source = "DashboardGeneral/images/signalLamps/battery24vFailure.png"                    
                }
                else {
                    battery24v_L.source = "DashboardGeneral/images/signalLamps/battery24v.png"
                }
                battery24Voltage_T.text = inputFloat.toFixed(1)
            }
            function onSendRequestDisablePersonToQml(inputUint) {
                if (inputUint) {
                    warningSound.play()
                    disablePersonRequest_L.lampOn()
                }
                else disablePersonRequest_L.lampOff()
            }
            function onSendInteriorLightingToQml(inputUint) {
                if (inputUint !== 0 ) {
                    interiorLighting_L.lampOn()
                    interiorLighting_T.text = inputUint + "%"
                }
                else interiorLighting_L.lampOff()

            }
            function onSendLiquidHeaterToQml(inputUint){
                if (inputUint) pumpWork_L.lampOn()
                else pumpWork_L.lampOff()
            }
            function onSendHammerStatusToQml(inputUint){
                if (inputUint) hammer_L.lampOn()
                else hammer_L.lampOff()
            }
            function onSendFireExtingStatusToQml(inputUint){
                if (inputUint) fireExting_L.lampOn()
                else fireExting_L.lampOff()
            }
            function onSendDoorValveToQml(inputUint){
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
                    door1Valve_L.lampOff()
                }
            }
            function onSendRampErrorToQml(inputUint){
                if (inputUint === 2) rampError_L.lampOn()
                else rampError_L.lampOff()
            }
        }
        Connections{
            target: driverCabin
            function onSendElecticHeatedSideWindowsStatusToQml(inputUint){
//                if (inputUint) asr_L.lampOn()
//                else asr_L.lampOff()
            }
            function onSendSeatHeatingStatusToQml(inputUint){
                if (inputUint) seatHeating_L.lampOn()
                else seatHeating_L.lampOff()
            }

            function onSendHeaterMirrorsStatusToQml(inputUint){
                //console.log(inputUint)
                if (inputUint === 1) mirrorHeating_L.lampOn()
                else if (inputUint === 2) mirrorHeating_L.lampOn()
                else mirrorHeating_L.lampOff()
            }
            function onSendWasherFluidLampToQml(inputUint){
                if (inputUint) {
                    washerFluidLevel_L.lampOn()
                    warningSound.play()
                }
                else washerFluidLevel_L.lampOff()
            }
            function onSendWipersStatusToQml(inputUint){
                if (inputUint !== 0) wipers_L.lampOn()
                else wipers_L.lampOff()

                if (inputUint === 1) wipers_L.source = "DashboardGeneral/images/signalLamps/windshield/windshield_1.png"
                if (inputUint === 2) wipers_L.source = "DashboardGeneral/images/signalLamps/windshield/windshield_2.png"
                if (inputUint === 4) wipers_L.source = "DashboardGeneral/images/signalLamps/windshield/windshield_delayed.png"
                if (inputUint === 7) wipers_L.source= "DashboardGeneral/images/signalLamps/windshield/windshieldAuto.png"
            }
            function onSendOperatorSeatDirectionSwitchToQml(inputUint){
                if (inputUint === 1) noDriver_L.lampOn()
                else noDriver_L.lampOff()
            }

            function onSendSeatBeltSwitchToQml(inputUint){
                if (inputUint === 0) seatBeltSwitch_L.lampOn()
                else seatBeltSwitch_L.lampOff()
            }
            function onSendRouteIndicatorToQml(inputUint){
                if (inputUint === 1){
                    route_L.lampOn()
                }
                else{
                    route_L.lampOff()
                }
            }
            function onSendHeatedSteeringToQml(inputUint){
                if (inputUint === 1){
                    heatedSteering_L.lampOn()
                }
                else{
                    heatedSteering_L.lampOff()
                }
            }
        }
        Connections {
            target: motor
            function onSend_pantToQml(inputUint){
                if (inputUint === 0 || inputUint === 15){
                    pantograph_L.lampOff()
                }
                else{
                    pantograph_L.lampOn()
                }
                if (inputUint === 2){
                    pantograph_L.source = "DashboardGeneral/images/signalLamps/battery/pantMove.png"
                }
                else if(inputUint === 1){
                    pantograph_L.source = "DashboardGeneral/images/signalLamps/battery/pantUp.png"
                }
                else if(inputUint === 3){
                    pantograph_L.source = "DashboardGeneral/images/signalLamps/battery/pantError.png"
                }
            }
            function onSendReadyToMoveToQml(inputUint){
                if (inputUint === 1){
                    readyToMove_L.lampOn()
                }
                else if (inputUint === 2){
                    readyToMove_L.lampToggle()
                }
                else {
                    readyToMove_L.lampOff()
                }
            }
            function onSendOverheatMotorToQml(inputUint){
                if (inputUint === 1){
                    errorSound.play()
                    motorOverheat_L.lampOn()
                }
                else if (inputUint === 2){
                    errorSound.play()
                    motorOverheat_L.lampToggle()
                }
                else {
                    motorOverheat_L.lampOff()
                }
            }
            function onSendActualGearToQml(inputString){
                if (inputString === "STOP"){
                    shiftSelector.viewShiftSelector(false, inputString)
                }
                else{
                    shiftSelector.viewShiftSelector(true, inputString)
                }
            }
            function onSendEngineLowCoolantLevelToQml(inputUint) {
                if (inputUint) {
                    errorSound.play()
                    lowCoolantEngineLevel_L.lampOn();
                }
                else if (inputUint === 2){
                    errorSound.play()
                    lowCoolantEngineLevel_L.lampToggle()
                }
                else lowCoolantEngineLevel_L.lampOff();
            }
            function onSendEngineLampToQml(inputUint) {
                if (inputUint === 2){
                    errorSound.play()
                    motorError_L.source = "DashboardGeneral/images/signalLamps/motorSystem/electricMotorFailure.png"
                    motorError_L.lampOn()
                }
                else if (inputUint === 3){
                    errorSound.play()
                    motorError_L.source = "DashboardGeneral/images/signalLamps/motorSystem/electricMotorFailure.png"
                    motorError_L.lampToggle()
                }
                else if (inputUint === 4){
                    warningSound.play()
                    motorError_L.source = "DashboardGeneral/images/signalLamps/motorSystem/electricMotorWarning.png"
                    motorError_L.lampToggle()
                }
                else if (inputUint === 1) {
                    warningSound.play()
                    motorError_L.lampOn()
                    motorError_L.source = "DashboardGeneral/images/signalLamps/motorSystem/electricMotorWarning.png"
                }
                else {
                    motorError_L.lampOff()
                }
            }
            function onSendFuelLevelToQml(inputUint) {
                //console.log(inputUint)
                if (inputUint < lowFuel_L.criticalLowlevel){
                    lowFuel_L.lampOn()
                }
                else if (inputUint < lowFuel_L.lowLevel && inputUint >= lowFuel_L.criticalLowlevel){
                    lowFuel_L.lampToggle()
                }
                else{
                    lowFuel_L.lampOff()
                }
            }
            function onSendBatteryStatusToQml(inputUint){
                if(inputUint === 1){
                    hvBatError_L.lampOn()
                    hvBatError_L.source = "DashboardGeneral/images/signalLamps/battery/batHvFail.png"
                }
                else if(inputUint === 2){
                    hvBatError_L.lampToggle()
                    hvBatError_L.source = "DashboardGeneral/images/signalLamps/battery/batHvFail.png"
                }
                else if(inputUint === 3){
                    hvBatError_L.lampOn()
                    hvBatError_L.source = "DashboardGeneral/images/signalLamps/battery/batHvWarning.png"
                }
                else if(inputUint === 4){
                    hvBatError_L.lampToggle()
                    hvBatError_L.source = "DashboardGeneral/images/signalLamps/battery/batHvWarning.png"
                }
                else{
                    hvBatError_L.lampOff()
                }
            }

            function onSendCirculationPumpToQml(inputUint) {
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
            function onSend_tmsErrorToQml(inputUint){
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
//            function onSend_tmsOnToQml(inputUint){
//                if(inputUint === 2){
//                    tmsHeating_L.lampOn()
//                }
//                else{
//                    tmsHeating_L.lampOff()
//                }
//            }
            function onSend_motorStatusToQml(inputUint){
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
            function onSend_steeringWheelToQml(inputUint){
                if(inputUint === 1){
                    steering_L.lampOn()
                    steering_L.source = "DashboardGeneral/images/signalLamps/steering/steeringOff.png"
                }
                else if(inputUint === 2){
                    steering_L.lampOn()
                    steering_L.source = "DashboardGeneral/images/signalLamps/steering/steeringFailure.png"
                }
                else{
                    steering_L.lampOff()
                }
            }
            function onSend_batteryHeatingToQml(inputUint){
                if(inputUint === 2){
                    tmsHeating_L.lampOn()
                }
                else{
                    tmsHeating_L.lampOff()
                }
            }
            function onSendLowPowerToQml(inputUint){
                if(inputUint === 1){
                    lowPower_L.lampOn()
                }
                else if(inputUint === 2){
                    lowPower_L.lampToggle()
                }
                else{
                    lowPower_L.lampOff()
                }
            }
            function onSend_externalCordToQml(inputUint){
                if(inputUint === 1){
                    externalCord_L.lampOn()
                }
                else if(inputUint === 2){
                    externalCord_L.togglingPeriod = 1000
                    externalCord_L.lampToggle()
                }
                else if(inputUint === 13){
                    externalCord_L.togglingPeriod = 500
                    externalCord_L.lampToggle()
                }
                else if(inputUint === 14){
                    externalCord_L.togglingPeriod = 500
                    externalCord_L.lampToggle()
                }
                else{
                    externalCord_L.lampOff()
                }
            }
            function onSend_isolationToQml(inputUint){
                if(inputUint === 5){
                    isolation_L.lampOn()
                    isolation_L.source = "DashboardGeneral/images/signalLamps/battery/insulationControlFailure.png"
                }
                else if(inputUint === 4){
                    isolation_L.lampToggle()
                    isolation_L.source = "DashboardGeneral/images/signalLamps/battery/insulationControlFailure.png"
                }
                else if(inputUint === 3){
                    isolation_L.lampOn()
                    isolation_L.source = "DashboardGeneral/images/signalLamps/battery/insulationControlWarning.png"
                }
                else if(inputUint === 2){
                    isolation_L.lampToggle()
                    isolation_L.source = "DashboardGeneral/images/signalLamps/battery/insulationControlWarning.png"
                }
                else{
                    isolation_L.lampOn()
                    isolation_L.source = "DashboardGeneral/images/signalLamps/battery/insulationControlOk.png"
                }
            }
            function onSend_contactorToQml(inputUint){
                if(inputUint === 2){
                    contactorError_L.lampToggle()
                }
                else{
                    contactorError_L.lampOff()
                }
            }
            function onSendServiceToQml(inputUint) {
                if (inputUint === 1) {
                    wrench_L.lampOn()
                }
                else{
                    wrench_L.lampOff()
                }
            }
        }
        Connections{
            target: suspension
            function onSendSuspensionStatusToQml(inputUint) {
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
            function onSendSuspensionErrorToQml(inputUint){
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
            function onSendKneelingStatusToQml(inputUint) {
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
            function onSendAutoKneelingStatusToQml(inputBool) {
    //            if (inputBool) autokneelingStatus_L.lampOn()
    //            else autokneelingStatus_L.lampOff()
            }
        }
        Connections {
            target: exteriorLightning
            function onSendExteriorLightsStatusToQml(inputUint) {
                if (inputUint === 1){
                    exteriorLightFailure_L.lampOn()
                }
                else{
                    exteriorLightFailure_L.lampOff()
                }

            }
            function onSendRightTurnSignalLightToQml(inputUint) {
                turnSignals.turnSignalRightSetState(inputUint)
            }
            function onSendLeftTurnSignalLightToQml(inputUint) {
                turnSignals.turnSignalLeftSetState(inputUint)
            }
            function onSendMarkerLightsToQml(inputUint){
                if (inputUint) markerLights_L.lampOn()
                else markerLights_L.lampOff()
            }
            function onSendRearFogLightsToQml(inputUint){
                if (inputUint) rearFogLight_L.lampOn()
                else rearFogLight_L.lampOff()
            }
            function onSendFrontFogLightsToQml(inputUint){
                if (inputUint) frontFogLights_L.lampOn()
                else frontFogLights_L.lampOff()
            }
            function onSendLowBeamHeadLightsToQml(inputUint){
                if (inputUint) lowBeamHeadLights_L.lampOn()
                else lowBeamHeadLights_L.lampOff()
            }
            function onSendHighBeamHeadLightsToQml(inputUint){
                if (inputUint) highBeamHeadLights_L.lampOn()
                else highBeamHeadLights_L.lampOff()
            }
            function onSendRunningLightsToQml(inputUint){
                if (inputUint) runningLights_L.lampOn()
                else runningLights_L.lampOff()
            }
        }

        Connections {
            target: adas
            function onSendLdwsToQml(inputUint){
                ldws_L.checkStatus(inputUint)
            }
            function onSendDeadZoneToQml(inputUint){
                deadZoneRight_L.checkStatus(inputUint)
                deadZoneLeft_L.checkStatus(inputUint)
            }
            function onSendObstacleToQml(inputUint){
                obstruction_L.checkStatus(inputUint)
            }
            function onSendLkasToQml(inputUint){
                lkas_L.checkStatus(inputUint)
            }
            function onSendFcwsToQml(inputUint){
                fkws_L.checkStatus(inputUint)
            }
            function onSendCruiseControlToQml(inputUint){
                if (inputUint === 1 || inputUint === 6){
                    cruiseControl_L.lampOn()
                }
                else if(inputUint === 7){
                    cruiseControl_L.lampToggle()
                }
                else{
                    cruiseControl_L.lampOff()
                }
            }
            function onSendParkingAssistanceToQml(inputUint){
                parkingAssistance_L.checkStatus(inputUint)
            }
        }
        Connections {
            target: tachograph
            function onSendTachographError(inputUint){
                if (inputUint !== 0){
                    tachographError_L.source = "DashboardGeneral/images/signalLamps/tachograph/tachographFailure.png"
                }
                tachographError_L.checkStatus(inputUint)
            }
            function onSendTachographWarning(inputUint){
                if (inputUint !== 0){
                    tachographError_L.source = "DashboardGeneral/images/signalLamps/tachograph/tachographWarning.png"
                }
                tachographError_L.checkStatus(inputUint)
            }
            function onSendTachographState(inputUint){
                if (inputUint === 0){
                    tachographStatus_L.source =  "DashboardGeneral/images/signalLamps/tachograph/rest.png"
                    tachographStatus_L.lampOn()
                }
                else if(inputUint === 2){
                    tachographStatus_L.source =  "DashboardGeneral/images/signalLamps/tachograph/workTime.png"
                    tachographStatus_L.lampOn()
                }
                else if(inputUint === 3){
                    tachographStatus_L.source =  "DashboardGeneral/images/signalLamps/tachograph/move.png"
                    tachographStatus_L.lampOn()
                }
                else{
                    tachographStatus_L.lampOff()
                }
            }
        }
        Connections {
            target: brakeSystem
            function onSendHillHolderIndicationToQml(inputUint){
                if (inputUint === 1){
                    hilHolder_L.lampOn()
                    warningSound.play()
                }
                else if (inputUint === 2){
                    hilHolder_L.togglingPeriod = 300
                    hilHolder_L.lampToggle()
                    warningSound.play()
                }
                else{
                    hilHolder_L.lampOff()
                }
            }
            function onSendASR_IndicationToQml(inputUint){
                if (inputUint === 2){
                    asr_L.lampOn()
                    warningSound.play()
                }
                else if (inputUint === 1){
                    asr_L.togglingPeriod = 300
                    asr_L.lampToggle()
                    warningSound.play()
                }
                else{
                    asr_L.lampOff()
                }
            }
            function onSendESC_IndicationToQml(inputUint){
                if (inputUint === 4){
                    esc_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/ESC_Off_2.png"
                    esc_L.lampToggle()
                    warningSound.play()
                }
                else if (inputUint === 3){
                    esc_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/ESC_Off_2.png"
                    esc_L.lampOn()
                    warningSound.play()
                }
                else if (inputUint === 2){
                    esc_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/ESC_On.png"
                    esc_L.lampOn()
                    warningSound.play()
                }
                else if (inputUint === 1){
                    esc_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/ESC_On.png"
                    esc_L.togglingPeriod = 300
                    esc_L.lampToggle()
                    warningSound.play()
                }
                else{
                    esc_L.lampOff()
                }
            }

            function onSendCompressorStateToQml(inputUint){
                if (inputUint === 2){
                   compressorError_L.lampOn()
                }
                else{
                    compressorError_L.lampOff()
                }
            }

            function onSendTractionControlToQml(inputUint){
//                if (inputUint === 1){
//                   tractionControl_L.lampOn()
//                   tractionControl_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/ASR_On.png"
//                }
//                else if (inputUint === 2){
//                   tractionControl_L.lampToggle()
//                   tractionControl_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/ASR_On.png"
//                }
//                else if (inputUint === 3){
//                   tractionControl_L.lampOn()
//                   tractionControl_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/ASR_Off.png"
//                }
//                else if (inputUint === 4){
//                   tractionControl_L.lampToggle()
//                   tractionControl_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/ASR_Off.png"
//                }
//                else{
//                    tractionControl_L.lampOff()
//                }
            }
            function onSendPressureCircuitParkBrakeToQml(inputUint){
                if (inputUint === 1) {
                    errorSound.play()
                    parkingBrake_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuitParkBrakeFailure.png"
                    parkingBrake_L.lampOn()
                }
                else if (inputUint === 2){
                    parkingBrake_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuitParkBrakeFailure.png"
                    parkingBrake_L.lampToggle()
                }
                else if (inputUint === 3){
                    parkingBrake_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/autoHold.png"
                    parkingBrake_L.lampOn()
                }
                else if (inputUint === 4){
                    parkingBrake_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/autoHold.png"
                    parkingBrake_L.lampToggle()
                }
                else if (inputUint === 5){
                    errorSound.play()
                    parkingBrake_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/errorEPB.png"
                    parkingBrake_L.lampOn()
                }
                else parkingBrake_L.lampOff()
            }
            function onSendEBS_IndicationToQml(inputUint){
                //console.log(inputUint)
                if (inputUint === 0) {
                    ebsState_L.lampOff()
                } else if (inputUint === 1) {
                    warningSound.play()
                    ebsState_L.lampOn()
                    ebsState_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/EBS_Yellow.png"
                } else if (inputUint === 2) {
                    errorSound.play()
                    ebsState_L.lampOn()
                    ebsState_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/EBS_Red.png"
                }
                else if (inputUint === 3) {
                    errorSound.play()
                    ebsState_L.lampToggle()
                    ebsState_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/EBS_Red.png"
                }

            }
            function onSendHaltBrakeStatusToQml(inputBool){
    //            if (inputBool) haltBrake_L.lampOn()
    //            else haltBrake_L.lampOff()
            }
            function onSendLowBrakePadsToQml(inputBool){
                if (inputBool) {
                    warningSound.play()
                    wornBrakeLinings_L.lampOn()
                }
                else wornBrakeLinings_L.lampOff()
            }
            function onSendPressureCircuit3LampToQml(inputBool) {
                if (inputBool) {
                    errorSound.play()
                    airBrake3_L.visible = true;
                    airBrake3_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit3Failure.png"
                }
                else airBrake3_L.visible = false
            }
            function onSendPressureCircuit4LampToQml(inputBool) {
                if (inputBool) {
                    errorSound.play()
                    airBrake4_L.visible = true;
                    airBrake4_L.source = "DashboardGeneral/images/signalLamps/brakeSystem/brakeCircuit4Failure.png"
                }
                else airBrake4_L.visible = false
            }
            function onSendRetarderPercentToQml(inputFloat){
                if(inputFloat > 0){
                    retarder_L.lampOn()
                }
                else {
                    retarder_L.lampOff()
                }
            }
            function onSendLowTirePressureToQml(inputBool){
//                if (inputBool){
//                    lowTirePressure_L.lampOn()
//                }
//                else {
//                    lowTirePressure_L.lampOff()
//                }
            }
        }


    SignalLamp_C {
        id: markerLights_L
        x: 688
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
        x: 1381
        y: 284
        width: 45
        height: lowTirePressure_L.width
        visible: false
        source: "DashboardGeneral/images/signalLamps/brakeSystem/lowTyrePressure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: battery24v_L
        x: 555
        y: 95
        width: 55
        height: battery24v_L.width
        source: "DashboardGeneral/images/signalLamps/battery24v.png"
        visible: true
        property bool lowVoltageStartSound: false
        property int errorLamp: 0

        Text {
            id: battery24Voltage_T
            width: 42
            height: 17
            color: "#ffffff"
            text: qsTr("--")
            anchors.verticalCenterOffset: 2
            anchors.horizontalCenterOffset: 0
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
        x: 858
        y: 11
        width: 57
        height: frontFogLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/frontFogLight.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: highBeamHeadLights_L
        x: 1187
        y: 11
        width: 57
        height: highBeamHeadLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/highBeamHeadLights.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: lowBeamHeadLights_L
        x: 1099
        y: 13
        width: 57
        height: lowBeamHeadLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/lowBeamHeadLights.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: rearFogLight_L
        x: 781
        y: 10
        width: 57
        height: rearFogLight_L.width
        source: "DashboardGeneral/images/signalLamps/lights/rearFogLight.png"
        test: signalLampTest
    }
    TurnSignals_C {
        id: turnSignals
        y: 10
        width: 761
        height: 60
        anchors.horizontalCenterOffset: 1
        togglingPeriod: 500
        anchors.horizontalCenter: parent.horizontalCenter
        distanceBetweenImages: 100
    }

    SignalLamp_C {
        id: exteriorLightFailure_L
        x: 937
        y: 17
        width: 46
        height: exteriorLightFailure_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/lights/exteriorBulbFailure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: suspensionStatus_L
        x: 1102
        y: 152
        width: 55
        height: suspensionStatus_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/suspension/heightControlNotNormal.png"
        test: signalLampTest
    }
    SignalLamp_C {
        id: runningLights_L
        x: 1014
        y: 11
        width: 58
        height: runningLights_L.width
        source: "DashboardGeneral/images/signalLamps/lights/runningLights.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: lowCoolantEngineLevel_L
        x: 1104
        y: 93
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
        x: 924
        y: 516
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
        x: 1643
        y: 411
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
        x: 1157
        y: 521
        width: 45
        height: hammer_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/busInterior/hammer.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: kneelingStatus_L
        x: 1172
        y: 153
        width: 50
        height: kneelingStatus_L.width
        source: "DashboardGeneral/images/signalLamps/suspension/kneeling.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: seatBeltSwitch_L
        x: 1247
        y: 521
        width: 44
        height: seatBeltSwitch_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/busCabin/seatBeltNotFastened.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: esc_L
        x: 520
        y: 526
        width: 50
        height: esc_L.width
        fillMode: Image.PreserveAspectFit
        source: "DashboardGeneral/images/signalLamps/brakeSystem/ESC_Off_2.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: washerFluidLevel_L
        x: 1099
        y: 521
        width: 48
        height: washerFluidLevel_L.width
        source: "DashboardGeneral/images/signalLamps/windshield/windshielFluidLevelWarning.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: wipers_L
        x: 742
        y: 514
        width: 45
        height: wipers_L.width
        source: "DashboardGeneral/images/signalLamps/windshield/windshield_delayed.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: mirrorHeating_L
        x: 801
        y: 522
        width: 44
        height: mirrorHeating_L.width
        source: "DashboardGeneral/images/signalLamps/busCabin/mirrorHeating.png"
        mirror: false
        test: signalLampTest
    }

    SignalLamp_C {
        id: route_L
        x: 680
        y: 521
        width: 45
        height: route_L.width
        visible: true
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
        x: 1208
        y: 521
        width: 45
        height: width
        visible: true
        source: "DashboardGeneral/images/menu/fireExtinguishersAndTaps/fireExtinguisherRed.png"
        fillMode: Image.PreserveAspectFit
        autoTransform: true
        test: signalLampTest
    }

    SignalLamp_C {
        id: noDriver_L
        x: 1297
        y: 521
        width: 44
        height: noDriver_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/busCabin/noDriverInTheSeat.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: door2Valve_L
        x: 797
        y: 345
        width: 44
        height: door2Valve_L.width
        source: "DashboardGeneral/images/menu/doors/valveYellow.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: rampError_L
        x: 1356
        y: 523
        width: 40
        height: rampError_L.width
        source: "DashboardGeneral/images/signalLamps/rampError.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: seatHeating_L
        x: 627
        y: 528
        width: 40
        height: width
        source: "DashboardGeneral/images/signalLamps/busCabin/seatHeating.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: door1Valve_L
        x: 997
        y: 363
        width: 44
        height: 44
        source: "DashboardGeneral/images/menu/doors/valveYellow.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: hvBatError_L
        x: 799
        y: 98
        width: 50
        height: width
        fillMode: Image.PreserveAspectFit
        source: "DashboardGeneral/images/signalLamps/battery/batHvFail.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: motorError_L
        x: 853
        y: 96
        width: 50
        height: width
        source: "DashboardGeneral/images/signalLamps/motorSystem/electricMotorFailure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: tmsError_L
        x: 676
        y: 92
        width: 55
        height: width
        source: "DashboardGeneral/images/signalLamps/battery/tmsFailure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: steering_L
        x: 619
        y: 97
        width: 50
        height: width
        source: "DashboardGeneral/images/signalLamps/steering/steeringFailure.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: tmsWarning_L
        x: 732
        y: 143
        width: 55
        height: width
        source: "DashboardGeneral/images/signalLamps/battery/tmsCoolantLowLevel.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: externalCord_L
        x: 1228
        y: 96
        width: 50
        height: externalCord_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/battery/externalCordConnect.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: isolation_L
        x: 1171
        y: 96
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

    SignalLamp_C {
        id: motorOverheat_L
        x: 851
        y: 148
        width: 45
        height: width
        test: signalLampTest
        source: "DashboardGeneral/images/signalLamps/motorSystem/engineCoolantTempFailure.png"
    }

    SignalLamp_C {
        id: readyToMove_L
        x: 1033
        y: 96
        width: 55
        height: readyToMove_L.width
        visible: true
        test: signalLampTest
        source: "DashboardGeneral/images/signalLamps/motorSystem/electricMotorEnabled.png"
    }

    SignalLamp_C {
        id: lowPower_L
        x: 1043
        y: 525
        width: 40
        height: width
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
        source: "DashboardGeneral/images/signalLamps/motorSystem/lowPower.png"
    }

    SignalLamp_C {
        id: pantograph_L
        x: 1332
        y: 114
        width: 30
        height: pantograph_L.width
        visible: true
        test: signalLampTest
        source: "DashboardGeneral/images/signalLamps/battery/pantMove.png"
    }

    SignalLamp_C {
        id: contactorError_L
        x: 1283
        y: 100
        width: 45
        height: contactorError_L.width
        visible: true
        test: signalLampTest
        source: "DashboardGeneral/images/signalLamps/battery/contactorFailure.png"
    }

    SignalLamp_C {
        id: compressorError_L
        x: 735
        y: 99
        width: 50
        height: width
        test: signalLampTest
        source: "DashboardGeneral/images/signalLamps/brakeSystem/compressorError.png"
    }

    SignalLamp_C {
        id: tractionControl_L
        x: 1371
        y: 345
        width: 45
        height: tractionControl_L.width
        visible: false
        test: signalLampTest
        source: "DashboardGeneral/images/signalLamps/brakeSystem/ASR_On.png"
    }

    SignalLamp_C {
        id: asr_L
        x: 477
        y: 523
        width: 44
        height: asr_L.width
        test: signalLampTest
        source: "DashboardGeneral/images/signalLamps/brakeSystem/ASR_Yellow.png"
    }

    SignalLamp_C {
        id: hilHolder_L
        x: 1661
        y: 345
        width: 56
        height: hilHolder_L.width
        test: signalLampTest
        source: "DashboardGeneral/images/signalLamps/brakeSystem/hillHolder.png"
    }
    SignalLamp_C {
        id: deadZoneRight_L
        x: 336
        y: 499
        width: 50
        height: deadZoneRight_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/ADAS/deadZoneRight.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: deadZoneLeft_L
        x: 369
        y: 499
        width: 50
        height: deadZoneLeft_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/ADAS/deadZoneLeft.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: obstruction_L
        x: 269
        y: 466
        width: 35
        height: width + 15
        visible: true
        source: "DashboardGeneral/images/signalLamps/ADAS/obstruction.png"
        fillMode: Image.PreserveAspectCrop
        test: signalLampTest
    }

    SignalLamp_C {
        id: ldws_L
        x: 205
        y: 348
        width: 47
        height: ldws_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/ADAS/ldws.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: lkas_L
        x: 212
        y: 278
        width: 65
        height: width - 25
        visible: true
        source: "DashboardGeneral/images/signalLamps/ADAS/lkas.png"
        fillMode: Image.PreserveAspectCrop
        test: signalLampTest
    }
    SignalLamp_C {
        id: tachographError_L
        x: 441
        y: 224
        width: 50
        height: tachographError_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/tachograph/tachographWarning.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: tachographStatus_L
        x: 360
        y: 275
        width: 30
        height: tachographStatus_L.width
        visible: false
        source: "DashboardGeneral/images/signalLamps/tachograph/workTime.png"
        fillMode: Image.PreserveAspectFit
        test: signalLampTest
    }

    SignalLamp_C {
        id: cruiseControl_L
        x: 443
        y: 471
        width: 42
        height: cruiseControl_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/motorSystem/cruiseControl.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: fkws_L
        x: 218
        y: 417
        width: 50
        height: fkws_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/ADAS/fkws.png"
        test: signalLampTest
    }
    SignalLamp_C {
        id: wrench_L
        x: 491
        y: 274
        width: 45
        height: wrench_L.width
        visible: true
        source: "DashboardGeneral/images/signalLamps/service.png"
        test: signalLampTest
    }

    SignalLamp_C {
        id: parkingAssistance_L
        x: 990
        y: 524
        width: 40
        height: parkingAssistance_L.width
        source: "DashboardGeneral/images/signalLamps/steering/parkingAssistance.png"
        mirror: false
        test: signalLampTest
    }

    SignalLamp_C {
        id: heatedSteering_L
        x: 577
        y: 522
        width: 45
        height: width+10
        source: "DashboardGeneral/images/signalLamps/steering/heatedSteering.png"
        fillMode: Image.PreserveAspectCrop
        test: signalLampTest
    }

    SignalLamp_C {
        id: lowFuel_L
        x: 809
        y: 156
        width: 30
        height: lowFuel_L.width
        fillMode: Image.PreserveAspectFit
        source: "DashboardGeneral/images/signalLamps/motorSystem/lowFuel.png"
        visible: false
        test: signalLampTest
        property int lowLevel: 25
        property int criticalLowlevel: 15
    }
}
