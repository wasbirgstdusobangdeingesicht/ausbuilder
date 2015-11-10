import QtQuick 2.0
import Qt.labs.settings 1.0
import "controls"
import "global.js" as Utils
import "models/de"

BasicScreen {
    id: tutorial
    anchors.fill: parent
    clip: true
    property var json
    focus: true

    property alias cardModel: testLoader.source
    property bool showKnown: true

//    onShowKnownChanged: buildModel()

    Settings {
        id: cardSettings
        category: "card_states"
        property string states: ""
    }

    function done() {
        console.log("done called")
        showScreen(nextScreen)
    }

    function loadFromSettings() {
        if(cardSettings.states === "") {
            json = {}
            return
        }
        var tutorialModel = mdl.item
        if(tutorialModel.count <= 0)
            return
        json = JSON.parse(cardSettings.states)
        if(json['model_'+tutorialModel.name] === undefined)
            return
        var states = json['model_'+tutorialModel.name]['states']
        var count = Math.min(tutorialModel.count, states.length)
        for(var i = 0; i < count; ++i)
        {
            tutorialModel.get(i).known = (0 >= states[i])
        }
    }

    function saveToSettings() {
        var tutorialModel = mdl.item
        if (tutorialModel.count <= 0)
            return
        if(json === undefined)
            json = {}
        if(json['index'] === undefined)
            json['index'] = 0
        if(json['model_'+tutorialModel.name] === undefined)
            json['model_'+tutorialModel.name] = {}
        var ind = json['index']
        json['index'] = ind+1
        json['model_'+tutorialModel.name]['index'] = ind
        var states = []
        for(var i = 0; i < tutorialModel.count; ++i)
        {
            states.push(tutorialModel.get(i).known? 0: 1)
        }
        json['model_'+tutorialModel.name]['states'] = states
        cardSettings.states = JSON.stringify(json)
    }
    function buildModel() {
        tutorialView.model.clear()
        indexMapping = []
        var tutorialModel = mdl.item
        var ciOld = indexMapping[tutorialView.currentIndex]
        var ciNew = -1
        for(var i = 0; i < tutorialModel.count; ++i)
        {
            if(showKnown || !tutorialModel.get(i).known)
            {
                tutorialView.model.append(tutorialModel.get(i))
                if(ciOld === i)
                    ciNew = indexMapping.length
                indexMapping.push(i)
            }
        }
        // preserve current index
        if(ciNew >= 0)
        {
            tutorialView.currentIndex = ciNew
        }
    }

    function play() {
        var props = {cardModel: mdl.item}
        initAndShowScreen("PlayPhrase.qml", props)
    }

    Component {
        id: tutorialDelegate

        Item {
            width: tutorial.width
            height: tutorial.height - Utils.scaled(70)
            property alias flipd: flipable.flipped
            property alias iKnewItBtn: iKnewIt
            Flipable {
                id: flipable
                anchors.fill: parent
                property string fronttext
                property string backtext
                property bool flipped: false
                property string clr: getColor()
//                function getColor() { return known? "lightgreen": "lightgray" }
                function getColor() { return known? "green": "black" }
                front: Card { anchors.fill: parent; text: txt; imgname: ""; brdcolor: flipable.clr }
                back:  Card { anchors.fill: parent; text: tr; imgname: ""/*"tutorial_0.png"*/; brdcolor: flipable.clr }

                transform: Rotation {
                    id: rotation
                    origin.x: flipable.width/2
                    origin.y: flipable.height/2
                    axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                    angle: 0    // the default angle
                }

                states: State {
                    name: "back"
                    PropertyChanges { target: rotation; angle: 180 }
                    when: flipable.flipped
                }

                transitions: Transition {
                    NumberAnimation { target: rotation; property: "angle"; duration: 500 }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: flipable.flipped = !flipable.flipped
                }
            }

            RoundBtn {
                id: iKnewIt
                anchors.right: parent.right
                anchors.top: parent.top
                width: Utils.scaled(48)
                imgSrc: svgPath(known? "symbol_tick.svg": "symbol_cross.svg")
                function doClicked() {
                    var tutorialModel = tutorialView.model
                    var nowKnown = !tutorialModel.get(index).known
                    tutorialModel.get(index).known = nowKnown
                    mdl.item.get(indexMapping[index]).known = nowKnown
                    flipable.clr = flipable.getColor()
//                    tick = nowKnown
                    console.log("RoundCrossBtn clicked")
                }
                onClicked: doClicked()
            }
        }
    }

    property var mdl: Loader {
        id: testLoader
        onLoaded: {
//            saveToSettings() // save previous
            console.log("item: " + item)
            loadFromSettings() // load new
            buildModel()
        }
    }
    property var indexMapping: []

    ListView {
        id: tutorialView
        anchors.fill: parent
//        model: tutorialModel
//        model: Loader {source: "01.2_Appearance.qml"}
        model: ListModel {}
        delegate: tutorialDelegate
        orientation: ListView.Horizontal
        highlightMoveDuration: 300
//        cacheBuffer: tutorialModel.count

        // Snapping
        // Note, docs say: snapMode does not affect the currentIndex.
        // To update the currentIndex as the list is moved,
        // set highlightRangeMode to ListView.StrictlyEnforceRange
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange

        onFlickStarted: if (atXEnd) done()
    }

    Row {
        y: parent.y + Utils.scaled(8)
        x: parent.x + Utils.scaled(8)
        spacing: Utils.scaled(8)

        RoundBtn {
            id: hideShowKnown
            width: Utils.scaled(48)
            imgSrc: svgPath(tutorial.showKnown? "symbol_eye_opened.svg": "symbol_eye_closed.svg")
            onClicked: {
                tutorial.showKnown = !tutorial.showKnown
                buildModel()
            }
        }

        RoundBtn {
            id: listen
            width: Utils.scaled(48)
            imgSrc: svgPath("symbol_sound.svg")
            onClicked: {
                play()
            }
        }
    }

    DottedScroll {
        numPages: tutorialView.count
        currPage: tutorialView.currentIndex

        onPageClicked: tutorialView.currentIndex = page
    }

//    Keys.onLeftPressed: console.log('left')

    Keys.onPressed: {
        console.log('pressed')
        var ind = tutorialView.currentIndex
        console.log(tutorialView.currentItem)
        if(Qt.Key_Left === event.key) {
            tutorialView.currentIndex = Math.max(ind-1, 0)
        }
        else if(Qt.Key_Right === event.key || Qt.Key_Space === event.key) {
            tutorialView.currentIndex = Math.min(ind+1, tutorialView.count-1)
        }
        else if(Qt.Key_PageDown === event.key) {
            tutorialView.currentIndex = Math.min(ind + 8, tutorialView.count-1)
        }
        else if(Qt.Key_PageUp === event.key) {
            tutorialView.currentIndex = Math.max(ind - 8, 0)
        }
        else if(Qt.Key_Home === event.key) {
            tutorialView.currentIndex = 0
        }
        else if(Qt.Key_End === event.key) {
            tutorialView.currentIndex = tutorialView.count-1
        }
        else if(Qt.Key_Up === event.key || Qt.Key_Down === event.key)
        {
            tutorialView.currentItem.flipd
                    = !tutorialView.currentItem.flipd
        } else if(Qt.Key_Enter === event.key || Qt.Key_Return === event.key)
        {
            tutorialView.currentItem.iKnewItBtn.clicked()
        } else if(Qt.Key_H === event.key)
        {
            tutorial.showKnown = false
            buildModel()
        } else if(Qt.Key_S === event.key)
        {
            tutorial.showKnown = true
            buildModel()
        } else if(Qt.Key_P === event.key)
        {
            play()
        }

    }

    Component.onCompleted: {
//        actionBar.visible = false
        if(tutorialView.count > 0)
            loadFromSettings()
    }
    Component.onDestruction: {
//        actionBar.visible = true
        if(tutorialView.count > 0)
            saveToSettings()
    }
}
