//import QtQuick 2.11
//import QtQuick.Window 2.11
import QtQuick 2.9
import QtQuick.Window 2.3
import QtMultimedia 5.9
import QtQml 2.5
import "DashboardGeneral/qmlUserClass/baseClasses"

Window {
    id: dashBoard
    visible: true
    width: 1920
    height: 720
    color: "#000000"
    title: qsTr("DashBoard")
    FpsItem_C{
        x: 0
        y: 0
        width: 140
        height: 34
        color: "#000000"
        z: 2
    }
    Loader {
        id: myLoader
        width: 1920
        height: 720
        asynchronous: true
        active: false
        source: "qrc:/main.qml"
        Image {
            id: logo
            x: 710
            y: 100
            width: 427
            height: 579
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            opacity: 0
            //fillMode: Image.PreserveAspectFit
            fillMode: Image.Stretch
            source: "/DashboardGeneral/images/logo.png"
            Component.onCompleted: {
                //myLoader.active = true
                a_incLogoOpacity.running = true
            }
        }
        PropertyAnimation {
            id: a_incLogoOpacity
            target: logo
            properties: "opacity"
            to: 0.8
            duration: 1000
            onStopped: {
                myLoader.active = true
            }
        }
    }
    Connections{
        target: dashboardObject
        function onSendAppViewToQml(inputBool){
            //console.log(inputBool)
            if (inputBool === true){
                logo.opacity = 0;
                myLoader.active = false;
            }
            else{
                a_incLogoOpacity.running = true
            }
        }
    }
}










































/*##^##
Designer {
    D{i:2;anchors_height:296;anchors_width:210;anchors_x:847;anchors_y:207}
}
##^##*/
