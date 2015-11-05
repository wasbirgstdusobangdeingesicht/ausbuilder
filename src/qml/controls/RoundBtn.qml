import QtQuick 2.0
import "../global.js" as Utils

Rectangle {
    property string imgSrc: ""
    Image {
        id: img
        source: parent.imgSrc
        anchors.fill: parent
        anchors.margins: 1
    }
    color: "white"
    opacity: .5
    anchors.margins: Utils.scaled(18)
    width: img.sourceSize.width
    height: width
    radius: width / 2
    signal clicked
    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
        onPressedChanged: img.scale = pressed ? 0.9 : 1
    }
}
