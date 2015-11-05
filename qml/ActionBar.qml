import QtQuick 2.0
import 'global.js' as Utils
import "models"
import "controls"

Rectangle{
    anchors.left: parent.left
    anchors.right: parent.right
    property int defaultHeight: Utils.scaled(70)
    height: visible ? defaultHeight : 0
    onVisibleChanged: height = visible ? defaultHeight : 0

    color: '#111e2b'

    signal actionButtonClicked()

    property string title: ""

    Rectangle {
        id: actionBtn
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        width: parent.height
        color: "transparent"

      MouseArea {
        anchors.fill: parent
        onClicked:{
            actionButtonClicked()
        }
      }

      MenuBackIcon {
        id: menuBackIcon
        anchors.centerIn: parent
      }
    }

    Text{
        anchors.margins: Utils.scaled(8)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: actionBtn.right
        anchors.right: parent.right

        horizontalAlignment: Text.AlignHCenter

        color: "white"
        text: title

        font.pixelSize: defaultHeight/3
        font.bold: true
    }

    function setStateMenuIco(stateMenu){
        if(menuBackIcon.state != stateMenu) {
            menuBackIcon.state = stateMenu
        }
    }
}
