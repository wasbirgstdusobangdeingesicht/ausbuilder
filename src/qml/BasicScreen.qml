import QtQuick 2.0
import './global.js' as Utils

Rectangle {
    id: root
    anchors.fill: parent
    color: Utils.mainBgColor

    signal showScreen(string filename)
    signal initAndShowScreen(string filename, var props)
    signal initScreen(string filename, var props)
    signal userInteraction() // to hide menu if open
    // TODO: flicking is not working this way
//    MouseArea {
//        anchors.fill: parent
//        z: 100
//        propagateComposedEvents: true // do not still clicks
//        onClicked: {
//            mouse.accepted = false; // do not still clicks
//            userInteraction();
//        }
//    }
}
