import QtQuick 2.0
import "delegates"
import "models"

Rectangle {
    ListView {
        id: listView
        anchors.fill: parent
        model: SlideMenuModel {
            id: menuListModel
        }

        delegate: SlideMenuDelegate {}
        onCurrentIndexChanged: {
            if (parent.activated)
            {
                var item = menuListModel.get(currentIndex)
                var props = item.props
                console.log("got props: " + props + " (" + JSON.stringify(props) + ")")
                console.log('itemcurrentIndex: ' + currentIndex)
                console.log('item:url: ' + item.url)
                var theurl = 'CardSelector.qml'
                if(item !== undefined && item.url !== undefined)
                {
                    theurl = item.url
                }
                if(undefined === props)
                    mainLoader.setSource(theurl)
                else
                    mainLoader.setSource(theurl, props)
                actionBar.title = item.title
            }
        }
    }

    property bool activated: false
    function setCurrentScreen(screen) {
        setCurrentScreenWithProps(screen, undefined)
    }

    function setScreenProps(screen, props) {
        for (var i = 0; i < menuListModel.count; ++i) {
            if (screen === menuListModel.get(i).url) {
                if(undefined !== props)
                    listView.model.get(i).props = props
            }
        }
    }

    function setCurrentScreenWithProps(screen, props) {
        console.log('switching screen to ' + screen)
        if (!activated) {
            activated = true
            listView.onCurrentIndexChanged()
        }
        for (var i = 0; i < menuListModel.count; ++i) {
            if (screen === menuListModel.get(i).url) {
                if(undefined !== props)
                    listView.model.get(i).props = props
                listView.currentIndex = i
            }
        }
    }
}
