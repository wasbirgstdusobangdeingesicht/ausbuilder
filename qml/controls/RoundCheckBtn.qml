import QtQuick 2.0
import "../global.js" as Utils

Rectangle {
    width: Utils.scaled(40)
    height: width
    radius: width / 2
    color: "transparent"
    border.color: "white"
   // border.width: Math.max(1, Math.round(width / 13))
    property string checkColor: "white"
    smooth: true
    signal clicked
    Rectangle {
        width: Math.max(1, Math.round(parent.width / 2.5))
        height: Math.max(1, Math.round(parent.width / 13))
        property double halfDiagonal: Math.sqrt((width*width + height*height)/2)/2
        color: parent.checkColor
        anchors {
            bottom: parent.bottom
            right: lineR.left
            bottomMargin: Math.round(parent.width/4 + halfDiagonal)
            rightMargin: Math.round(-halfDiagonal-height/Math.sqrt(2))+1
        }
        rotation: 45
        smooth: true
    }

    Rectangle {
        id: lineR
        width: Math.max(1, Math.round(parent.width / 1.75))
        height: Math.max(1, Math.round(parent.width / 13))
        property double halfDiagonal: Math.sqrt((width*width + height*height)/2)/2
        color: parent.checkColor
        anchors {
            bottom: parent.bottom
            left: parent.horizontalCenter
            bottomMargin: Math.round(parent.width/4 + halfDiagonal)
            leftMargin: Math.floor(-parent.width / 5 )
        }
        rotation: -45

        smooth: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
        onPressedChanged: parent.scale = pressed ? 0.9 : 1.0
    }
}
