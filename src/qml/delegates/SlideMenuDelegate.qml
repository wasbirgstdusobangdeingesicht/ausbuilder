import QtQuick 2.0

import '../global.js' as Utils

Component {

    Row {
        width: listView.width
        height: Utils.scaled(60)
        readonly property bool isCurrentItem : (listView.currentIndex === index)
        Item {
            id: itemRect
            width: listView.width
            height: parent.height
            Rectangle{
                anchors.fill: itemRect
                color: isCurrentItem ? Utils.mainBgColor : "white"
            }
            Text {
                anchors.topMargin: Utils.scaled(10)
                anchors.bottomMargin: Utils.scaled(10)
                anchors.leftMargin: Utils.scaled(15)
                anchors.rightMargin: Utils.scaled(15)
                id: itemText
                anchors.fill: parent
                //anchors.margins: 10
                horizontalAlignment: Text.AlignLeft
                renderType: Text.NativeRendering
                text: title
                color: isCurrentItem ? "white" : Utils.mainBgColor
                font.pointSize: 16
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    listView.currentIndex = model.index
                    theMainWindow.toggleMenu()
                }
            }

            //                    states: [
            //                        State {
            //                            name: "selected"
            //                            when: (title == currentIndex)
            //                            PropertyChanges {target: itemRect; color: "#00353e"}
            //                            PropertyChanges {target: itemText; color: "#ffffff"}
            //                        }
            //                    ]


            Rectangle {
                width: parent.width
                height: Utils.scaled(1)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: itemRect.bottom
                color: "#33000000"
            }
        }
    }
}
