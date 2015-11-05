import QtQuick 2.0
import "../global.js" as Utils

Row{
    id: dots
    property int numPages: 1
    property int currPage: 0

    signal pageClicked(int page)

    visible: numPages > 1

    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.margins: Utils.scaled(10)
    spacing: Utils.scaled(10)

    Repeater{
        model: parent.numPages
        Rectangle {
            width: Utils.scaled(12)
            height: Utils.scaled(12)
            radius: Utils.scaled(6)
            color: dots.currPage == index ? Utils.myGreen : "white"

            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    dots.pageClicked(index)
                }
            }
        }
    }
}
