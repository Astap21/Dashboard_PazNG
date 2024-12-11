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
//    FpsItem_C{
//        x: 0
//        y: 0
//        width: 140
//        height: 34
//        color: "#000000"
//        z: 2
//    }
    Loader {
        id: myLoader
        width: 1920
        height: 720
        asynchronous: true
        active: false
        source: "qrc:/main.qml"
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
    Image {
        id: logo
        x: 746
        y: 70
        width: 427
        height: 579
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        opacity: 0
        fillMode: Image.Stretch
        source: "/DashboardGeneral/images/logo.png"
        Component.onCompleted: {
            a_incLogoOpacity.running = true
        }

        Text {
            id: softVersion
            text: qsTr("Новая версия ПО " + dashboardObject.softVersionStr)
            anchors.bottom: parent.top
            anchors.bottomMargin: 15
            font.family: "Arial"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 35
            width: parent.width
            color: "#ffffff"
            visible: dashboardObject.flagNewSoftVersion
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
