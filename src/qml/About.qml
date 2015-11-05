import QtQuick 2.0
import "global.js" as Utils
import QtQuick.Window 2.1

BasicScreen {
    id: legal
    height: Screen.height
    width: Screen.width

    Text {
        anchors.fill: parent
        wrapMode: Text.WordWrap
        font.pixelSize: Utils.scaled(25)
        color: "white"
        text: "Denglish Sprachtrainer. <br>"+
              "Quelle von Kartenmaterial: <a href=\"https://github.com/rteabeault/Flashcard/\">https://github.com/rteabeault/Flashcard/</>"
    }

    Connections {
        target: theMainWindow
        onBackPressed: showScreen(nextScreen)
    }

    Component.onCompleted: doLayout()
}
