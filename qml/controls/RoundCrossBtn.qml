import QtQuick 2.0
import "../global.js" as Utils

Rectangle {
    id: crossButton
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.margins: Utils.scaled(18)
    width: Utils.scaled(40)
    height: width
    radius: width / 2
    color: "transparent"
    border.color: "white"
    property string crossColor: "white"
    property bool tick: false
    smooth: true
    signal clicked

    Item {
        clip: true
        anchors.centerIn: parent
        width: parent.width * (tick? 0.9: 0.75)
        height: parent.height * (tick? 0.9: 0.75)
        Item {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height
            transform: Scale { yScale: tick? 2: 1; xScale: 1 }
            Rectangle {
                width: parent.width * (tick? 0.7: 1)
                height: Math.max(1, Math.round(parent.width / (tick? 20: 10)))
                color: crossButton.crossColor
                anchors.centerIn: parent
                rotation: 45
                smooth: true
            }
            Rectangle {
                width: parent.width
                height: Math.max(1, Math.round(parent.width / (tick? 20: 10)))
                color: crossButton.crossColor
                anchors.centerIn: parent
                rotation: -45
                smooth: true
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
        onPressedChanged: parent.scale = pressed ? 0.9 : 1.0
    }
}
