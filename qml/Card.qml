import QtQuick 2.0
import "controls"
import "global.js" as Utils

Rectangle {
    id: placeHolder
    property string imgname
    property string text
    property alias bkgcolor: background.color
//    property alias brdcolor: bordr.border.color
    property string brdcolor: "black"

    color: "transparent"
    Rectangle {
        id: bordr
        anchors.fill: parent
        border.width: 3
        border.color: brdcolor
        color: "transparent"
    }
    Rectangle {
        id: background
        anchors.fill: parent
        color: "lightgray"
        opacity: .3
    }
    Image {
        id: img
        fillMode: Image.PreserveAspectFit
        source: imgname == ""? "": imagesPath + imgname
        anchors.fill: parent
    }
    Text {
        id: txt
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: parent.text
        font.family: Utils.fontFamily
        font.pointSize: 17
        color: Utils.myGreen
        wrapMode: Text.Wrap
    }
    Component.onCompleted: txt.doLayout()
}
