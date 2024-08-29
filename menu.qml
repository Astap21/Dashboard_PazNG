import QtQuick 2.0
import QtQuick.Controls 2.12
import "DashboardGeneral/qmlUserClass/menuItem"

Item {
    id: menuItem
    width: 1155
    height: 600
    opacity: 0.95
    signal menuOff(bool menuStateOff)
    Connections  {
        target: connectionFromCpp
        onSendButtonRightStateToQml: {
            if (!swipeViewMenu.lockedStatus) {
                if ((swipeViewMenu.currentIndex == swipeViewMenu.maxIndex) && (state === 1)) swipeViewMenu.setCurrentIndex(0)
                else if ((swipeViewMenu.currentIndex !== swipeViewMenu.maxIndex) && (state === 1)) {
                    swipeViewMenu.incrementCurrentIndex()
                }
            }
        }
        onSendButtonLeftStateToQml: {
            if (!swipeViewMenu.lockedStatus) {
                if ((swipeViewMenu.currentIndex == 0) && (state === 1)) swipeViewMenu.setCurrentIndex(swipeViewMenu.maxIndex)
                else if ((swipeViewMenu.currentIndex !== 0) && (state === 1)) {
                    swipeViewMenu.decrementCurrentIndex()
                }
            }
        }
        onSendButtonOkStateToQml: {
            //console.log("buttonOk Menu")
            //if (state && !setting.locked) menuItem.menuOff(true)
        }
        onSendButtonBackStateToQml: {
            //console.log("buttonBack Menu")
            //console.log(swipeViewMenu.lockedStatus)
            if (state) {
                if (!swipeViewMenu.lockedStatus){
                    if (state) {
                        menuItem.menuOff(true)
                    }
                }
                else{
                    swipeViewMenu.lockedStatus = false
                }
            }
        }
        onSendButtonMenuStateToQml: {
            //console.log("buttonMenu Menu")
            if (state) {
                menuItem.menuOff(true)
            }
        }
    }
    SwipeView {
        height: parent.height
        rightPadding: -400
        leftPadding: 0
        currentIndex: 0
        id: swipeViewMenu
        property bool lockedStatus: false
        Component.onCompleted: {
            connectionFromCpp.receiveMenuStatusFromQml(true)
        }
        property int maxIndex: setting.itemIndex
        width: 1155
//        Timer {
//            interval: 100; running: true; repeat: true
//            onTriggered: {
//                if (true == true)
//                swipeViewMenu.currentItem.opacity = 0
//            }

//        }
        BrakesAndTiresInfo_M{
            itemIndex: 0
        }
        Wipers_M{
            itemIndex: 1
        }
//        AxleLoad_M{
//            itemIndex: 2
//        }
//        Suspension_M{
//            itemIndex: 3
//        }
//        DisableFaults_M{
//            itemIndex: 4
//        }
//        ClimateControl_M{
//            itemIndex: 4
//        }
//        FireExtinguishersAndValves_M{
//            itemIndex: 5
//        }
//        DoorControl_M{
//            itemIndex: 6
//        }
        Settings_M{
            id: setting
            itemIndex: 2
        }
    }
}

        //Обычно не рекомендуется добавлять чрезмерное количество страниц в SwipeView.
        //Однако, когда количество страниц увеличивается или отдельные страницы становятся
        // относительно сложными, может быть желательно высвободить ресурсы путем выгрузки страниц,
        //которые находятся вне непосредственной досягаемости пользователя
        // для этого используется active:
        //https://doc.qt.io/qt-5/qml-qtquick-controls2-swipeview.html
//        Repeater {
//            model: swipeViewMenu.maxIndex + 1
//            //model: 3

//            Loader {
//                id: myLoader

//                active: SwipeView.isCurrentItem
//                //source: "qrc:/qmlUserClass/menuItem/propulsionBattery.qml"
//                //property bool suka: false
//                Component.onCompleted: {
//                    //suka = true
//                    swipeViewMenu.setCurrentIndex(0)
//                    //myLoader.setSource("qrc:/qmlUserClass/menuItem/propulsionBattery.qml")
//                }
//                sourceComponent: Text {
//                    text: index
//                    Component.onCompleted: console.log("created:", index)
//                    Component.onDestruction: console.log("destroyed:", index)
//                }
//                SwipeView.onIndexChanged: {
//                    console.log(swipeViewMenu.changeMenuItemFlag)
//                    if (swipeViewMenu.changeMenuItemFlag){
//                        console.log(index)
//                        if (index == 0) {
//                            source = "qrc:/qmlUserClass/menuItem/propulsionBattery.qml"
//                        }
//                        else if (index == 1) {
//                            source = "qrc:/qmlUserClass/menuItem/energyGraph.qml"
//                        }
//                        else if (index == 2) {
//                            source = "qrc:/qmlUserClass/menuItem/tractionInverter.qml"
//                        }
//                        else if (index == 3) {
//                            source = "qrc:/qmlUserClass/menuItem/brakesAndTiresInfo.qml"
//                        }
//                        else if (index == 4) {
//                            source = "qrc:/qmlUserClass/menuItem/energyConsumption.qml"
//                        }
//                        else if (index == 5) {
//                            source = "qrc:/qmlUserClass/menuItem/serviceInfo.qml"
//                        }
//                        else if (index == 6) {
//                            source = "qrc:/qmlUserClass/menuItem/settings.qml"
//                        }
//                    }
//                }
//            }
//        }



