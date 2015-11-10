import QtQuick 2.2
import "global.js" as Utils

BasicScreen {
    id: splash

    opacity: 0

    OpacityAnimator on opacity{
        from: 0
        to: 1
        duration: 1000
        running: true
    }

    Text {
        text: " ausbilder\n einfacher deutsch-englische trainer"
        font.pixelSize: Utils.scaled(25)
        color: "white"
        anchors.centerIn: parent
        wrapMode: Text.WordWrap
        Component.onCompleted: doLayout()
    }

    Timer {
        id: timer
        interval: 2000 // 1 secs
        running: false
        onTriggered: showScreen(nextScreen)
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: showScreen(nextScreen)
    }

    Component.onCompleted:{
        timer.start()
    }

    Connections {
        target: theMainWindow
        onBackPressed: Qt.quit()
    }
}
