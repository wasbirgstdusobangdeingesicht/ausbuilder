import QtQuick 2.2
import QtQuick.Controls 1.2

import "controls"
import "global.js" as Utils

BasicScreen {
    id: playPhraseMainScreen
    property var cardModel

    Text {
        id: phraseTextControl
        wrapMode: Text.WordWrap
        color: "white"
        font.family: Utils.fontFamily
        font.pointSize: 26
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.fill: parent
    }

    PlayerControls {
        id: playerControls
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Utils.scaled(18)
    }

    function num(i) {
        if(i < 10)
            return '00'+i
        else if(i < 100)
            return '0' +i
        else
            return ''+i
    }

    function audio(dir, name) {
        return dir + '/' + name + '.mp3'
    }

    Component.onCompleted: {
        // build audio model
        if(cardModel === undefined)
            return
        var mdl = []
        var diraudio = audioRoot + cardModel.name
        for(var i = 0; i < cardModel.count; ++i)
        {
            var item = cardModel.get(i)
            if(item.known)
                continue
            var ind = num(i+1)
            mdl.push(playerControls.makeExecutor('doShowText', item.txt))
            mdl.push(playerControls.makeExecutor('doPlay', audio(diraudio, ind + '_001_')))
            mdl.push(playerControls.makeExecutor('doDelay', 1000))
            mdl.push(playerControls.makeExecutor('doPlay', audio(diraudio, ind + '_003_')))
            mdl.push(playerControls.makeExecutor('doDelay', 1000))
            mdl.push(playerControls.makeExecutor('doPlay', audio(diraudio, ind + '_005_')))
            mdl.push(playerControls.makeExecutor('doDelay', 2000))
            mdl.push(playerControls.makeExecutor('doShowText', item.tr))
            mdl.push(playerControls.makeExecutor('doPlay', audio(diraudio, ind + '_007_')))
            mdl.push(playerControls.makeExecutor('doDelay', 1000))
            mdl.push(playerControls.makeExecutor('doPlay', audio(diraudio, ind + '_009_')))
            mdl.push(playerControls.makeExecutor('doDelay', 1000))
        }

        playerControls.model = mdl
    }

    Connections {
        target: theMainWindow
        onBackPressed: mainLoader.source = tmp.back
    }

}
