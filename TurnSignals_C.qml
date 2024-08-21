import QtQuick 2.11
import QtMultimedia 5.12

Item {
    id: turnSignals
    x: 0
    y: 0
    width: 220
    height: 60
    property int distanceBetweenImages: 100
    property bool test: false
    property int togglingPeriod: 400
    SignalLamp_C {
        id: turnSignalLeft_L
        x: 0
        y: 0
        width: height
        height: turnSignals.height
        fillMode: Image.PreserveAspectFit
        source: "DashboardGeneral/images/signalLamps/turnSignals/leftTurnSignal.png"
        test: turnSignals.test
        property bool turnStateOn: false
    }
    SignalLamp_C {
        id: turnSignalRight_L
        y: 0
        width: height
        height: turnSignals.height
        anchors.right: parent.right
        fillMode: Image.PreserveAspectFit
        source: "DashboardGeneral/images/signalLamps/turnSignals/rightTurnSignal.png"
        anchors.rightMargin: 0
        test: turnSignals.test
        property bool turnStateOn: false
    }
    function turnSignalLeftSetState(_state){
        if (_state) {
            turnSignalLeft_L.turnStateOn = true
            if (!turnSignalRight_L.turnStateOn){
                lampsToggle(1)
            }
        }
        else {
            turnSignalLeft_L.turnStateOn = false
            if (!turnSignalRight_L.turnStateOn) {
                lampsOff()
            }
        }
    }
    function turnSignalRightSetState(_state){
        if (_state) {
            turnSignalRight_L.turnStateOn = true
            if (!turnSignalLeft_L.turnStateOn){
                lampsToggle(2)
            }
        }
        else {
            turnSignalRight_L.turnStateOn = false
            if (!turnSignalRight_L.turnStateOn) {
                lampsOff()
            }
        }

    }
    function lampsToggle(turnId){
        if (!timerTurnToggle.running) {
            //console.log(turnId)
            turnSignalSound.play()
            timerTurnToggle.start()
        }
    }
    function lampsOff(){
        timerTurnToggle.stop()
        turnSignalLeft_L.visible = false
        turnSignalRight_L.visible = false
        timerTurnToggle.running = false
        turnSignalSound.stop()
    }
    function lampsOn(){
        turnSignalLeft_L.visible = true
        turnSignalRight_L.visible = true
    }
    function turnRightOn(){
        turnSignalRight_L.visible = true
        exteriorLightning.RightTurnLight_lamp = turnSignalRight_L.visible
    }
    function turnRightOff(){
        turnSignalRight_L.visible = false
        exteriorLightning.RightTurnLight_lamp = turnSignalRight_L.visible
    }
    function turnLeftOn(){
        turnSignalLeft_L.visible = true
    }
    function turnLeftOff(){
        turnSignalLeft_L.visible = false
    }
    SoundEffect{
        id: turnSignalSound
        source: "qrc:/DashboardGeneral/sound/turnSignalSound.wav"
        volume: 1.0
    }
    Timer {
        id: timerTurnToggle
        interval: togglingPeriod; running: false; repeat: true
        onTriggered: {
            //console.log("turnSignalLeft_L.visible ")
            //console.log(turnSignalLeft_L.visible)
            //cинхронное включение двух поворотников
            if (turnSignalRight_L.turnStateOn && turnSignalLeft_L.turnStateOn) {
                if (turnSignalRight_L.visible){
                    turnSignalRight_L.visible = false
                    turnSignalLeft_L.visible = false
                }
                else{
                    turnSignalRight_L.visible = true
                    turnSignalLeft_L.visible = true
                }
            }
            //асинхронная работа
            else{
                if (turnSignalRight_L.turnStateOn && !turnSignalRight_L.visible) {
                    turnSignalRight_L.visible = true
                }
                else {
                    turnSignalRight_L.visible = false
                }
                if (turnSignalLeft_L.turnStateOn && !turnSignalLeft_L.visible) {
                    turnSignalLeft_L.visible = true
                }
                else {
                    turnSignalLeft_L.visible = false
                }
            }
            //console.log("right " + turnSignalRight_L.visible)
            //console.log("left " + turnSignalLeft_L.visible)
            if(turnSignalRight_L.visible || turnSignalLeft_L.visible){
                turnSignalSound.stop()
                turnSignalSound.play()
                //console.log("*")
            }
            //exteriorLightning.RightTurnLight_lamp = turnSignalRight_L.visible
        }
    }
}
