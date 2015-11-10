import QtQuick 2.0
import Qt.labs.settings 1.0
import QtQuick.Window 2.0

import "qml"
import "qml/models"
import "qml/global.js" as Utils

Rectangle {
    id: theMainWindow
    objectName: "theMainWindow"
    anchors.fill: parent
    // uncomment these 2 lines to have full-screen mode
//    height: Screen.height
//    width: Screen.width

    visible: true
    color: "black"

//    focus: true

    property int dpi: Screen.pixelDensity * 25.4
    function ppiRange() {
        //   var rangeNames  = ["MDPI","HDPI","XHDPI","XXHDPI","XXXHDPI","XXXXHDPI"];
        //   var rangeBounds = [135, 180, 270, 360, 540];
        var rangeNames = ["hdpi", "xhdpi", "xxhdpi"]
        var rangeBounds = [180, 270]
        var i = 0
        while (i < rangeBounds.length && dpi > rangeBounds[i]) ++i
        return rangeNames[i]
    }
    property string imagesPath: "qrc:/assets/images/drawable-" + ppiRange() + "/"
    function svgPath(file) { return "qrc:/assets/design/" + file; }

    property string nextScreen: "CardSelector.qml"

    Flickable {
        id: flick
        property int previousClientX: 0
        boundsBehavior: Flickable.StopAtBounds
        flickDeceleration: 0

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: actionBar.bottom
        contentWidth: slidingMenu.width + normalView.width
        contentHeight: parent.height - actionBar.height
        onContentWidthChanged: {
            if(flick.state === 'hidden')
                flick.contentX = slidingMenu.width;
            else
                flick.contentX = 0;
        }

        interactive: false

        SlidingMenu {
            id: slidingMenu
            width: Utils.scaled(400)
            height: parent.height
        }

        MouseArea {
            id: flickingArea
            anchors.left: slidingMenu.right
            width: 10
            height: parent.height
            opacity: 0
        }

        Rectangle {
            id: normalView
            anchors.left: slidingMenu.right
            width: theMainWindow.width
            height: parent.height
            color: "transparent"
            Loader {
                id: mainLoader
                anchors.fill: parent
                onLoaded: console.log("Loader", mainLoader.source, mainLoader.status)
                focus: true
            }

            Connections {
                target: mainLoader.item
                onShowScreen: {
                    actionBar.visible = true
                    slidingMenu.setCurrentScreen(filename)
                }
                onInitAndShowScreen: {
                    actionBar.visible = true
                    slidingMenu.setCurrentScreenWithProps(filename, props)
                }

                onInitScreen: {
                    slidingMenu.setScreenProps(filename, props)
                }

                onUserInteraction: {
                    flick.state = "hidden"
                }
            }
        }
        transitions: Transition {
            PropertyAnimation { properties: "contentX"; easing.type: Easing.InOutQuad; duration: 400; }
        }
        state: "hidden"
        states: [ State {
                name: 'shown'
                StateChangeScript{
                    script: actionBar.setStateMenuIco("back")
                }
                PropertyChanges { target: flick; contentX: 0 }
            }, State {
                name: 'hidden'
                StateChangeScript{
                    script: actionBar.setStateMenuIco("menu")
                }
                PropertyChanges { target: flick; contentX: slidingMenu.width }
            }

        ]
        onMovementStarted: previousClientX = contentX
        onMovementEnded: {
            if (previousClientX > 0 && contentX < slidingMenu.width / 10) {
                contentX = 0
            } else {
                contentX = slidingMenu.width
            }
        }
    }

    Component.onCompleted: {
        console.log('main.qml: onCompleted')
        mainLoader.setSource("qml/Splash.qml")
        console.log('main.qml: showing splash')
//        loadFavoritesModelFromSettings()
    }

    ActionBar {
        id: actionBar
        width: parent.width
        anchors.top: parent.top
        visible: false

        title: ''
    }

    Connections{
        target: actionBar
        onActionButtonClicked: flick.state = flick.state == "hidden" ? "shown" : "hidden"
    }

    // needed to reload page in debug
    FocusScope {
        focus: true
        Keys.onPressed: {
            if (debug && event.key === Qt.Key_F5) {
                reloadScreen()
            }
        }

        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                console.log("Back button pressed.")
                event.accepted = true
                backPressed()
            }
        }
    }
    signal backPressed()

    Item {
        id: tmp
        property var thePhrase // temp object to pass phrase to the play screen
        property string back: nextScreen
    }

    function toggleMenu() {
        if (flick.state === 'hidden')
            flick.state = "shown"
        else
            flick.state = "hidden"
    }

    signal clearComponentCache
    function reloadScreen() {
        // reload page (seems its not working for now)
        clearComponentCache()
        var src = mainLoader.source
        mainLoader.source = ''
        mainLoader.source = src
    }

}
