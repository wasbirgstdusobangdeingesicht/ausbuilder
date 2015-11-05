import QtQuick 2.0
import "global.js" as Utils

BasicScreen {
    id: rootScreen

    property string defTextColor: "white"
    property string htmlText: ""
    property string devSpec: ppiRange()

    Flickable {
        id: flickable
        anchors.fill: parent
        anchors.margins: Utils.scaled(12)
        contentHeight: placeholder.height
        clip: true
        flickableDirection: Flickable.VerticalFlick

        Column {
            id: placeholder
            width: parent.width

            Text {
                id: htmlBody
                width: parent.width

                wrapMode: Text.WordWrap
                color: defTextColor
                text: htmlText
                font.family: Utils.fontFamily
                font.pointSize: 20

                onLinkActivated: Qt.openUrlExternally(link)
            }

            Image {
                source: imagesPath + "logo.png"
                height: htmlBody.font.pixelSize
                fillMode: Image.PreserveAspectFit
                transformOrigin: Item.TopLeft
            }
        }
    }
}
