import QtQuick 2.9

Image {
    id: signalLamp
    x: 0
    y: 0
    width: 100
    height: 100
    visible: true
    source: "DashboardGeneral/images/signalLamps/brakeSystem/errorEPB.png"
    property bool test: false
    property int textMessageNumberString: -1
    property bool toggling: false
    property string textMessage: "No message"
    property int togglingPeriod: 500
    // сделать состояние лампы в виде 4 бит одного байта
    // старшие 4 бит это период моргания, где 0 это вкл постоянно
    // младшие 4 бита это цвет (т.е путь к картинке), где 0 это лампа выключена
    // передавать этот байт в lampOn:  и на основе этого зажигать её


    function lampOn(textArea){
        lampOff(textArea) // так мы выключаем моргание
        visible = true
        //console.log(textMessage)
        if (textMessageNumberString === -1 && textMessage != "No message" && textArea !== undefined){
            textMessageNumberString = textArea.insertRowToArray(textMessage)
        }
        else if(textArea === undefined && textMessage != "No message") {
            console.log("textArea === undefined")
        }
    }
    function lampOff(textArea){
        if(textArea === undefined && textMessage != "No message") {
            console.log("textArea === undefined")
            console.log(signalLamp.source)
        }
        if (textMessageNumberString != -1){
            textArea.deleteRowFromArray(textMessage)
            textMessageNumberString = -1
        }
        //во время теста лампы всегда горят
        if (test) visible = true
        else visible = false

        timerToggle.stop()
        toggling = false
    }
    function lampToggle(textArea){
        if (toggling === false){
            if (timerToggle.running === false) {
                lampOn(textArea)
                timerToggle.start()
                toggling = true
            }
        }
    }
    function changeStatus(status, textArea){
       if(status === 1){
           lampOn(textArea)
       }
       else if (status === 2){
           lampToggle(textArea)
       }
       else{
           lampOff(textArea)
       }
    }
    function changeStatusAndPlayWarning(status, textArea){
       if(status === 1){
           warningSound.play()
       }
       changeStatus(status, textArea)
    }
    function changeStatusAndPlayError(status, textArea){
       if(status === 1){
           errorSound.play()
       }
       changeStatus(status, textArea)
    }
    Timer {
        id: timerToggle
        interval: togglingPeriod; running: false; repeat: true
        onTriggered: {
            if (signalLamp.visible === false) {
                signalLamp.visible = true
            }
            else signalLamp.visible = false
        }
    }
}
