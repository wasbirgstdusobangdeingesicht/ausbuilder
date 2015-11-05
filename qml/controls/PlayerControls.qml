import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtMultimedia 5.0
import "../global.js" as Utils
import "../controls"

Rectangle {
    color: "transparent"
    property bool isPlaying: false
    property bool isPaused: false
    property string filesToPlay: ""

    property var audioSource: filesToPlay.split(",")

    property alias model: audioController.model
    function makeExecutor(func, arg) {
        return audioController.makeExecutor(func, arg)
    }


    // the following properties needed to access some subcontrols outside PlayerControls.qml
    property alias playPauseBtnA: playPauseBtn
//    property alias audioSeekSliderA: audioSeekSlider

    Component.onCompleted: {
        audioController.start()
    }
    Component.onDestruction: {
        audioController.stop()
    }

    RoundBtn {
        id: playPauseBtn
        property alias stopped: audioController.stopped
        imgSrc: svgPath(stopped? "button_play.svg": "button_pause.svg")
        width: Utils.scaled(64)
        color: "white"
        opacity: .5
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: Utils.scaled(16)

        onClicked: {stopped? audioController.start() : audioController.stop()}
    }

    Item{
        id: audioController

        function stop() {
            if(stopped)
                return
            stopped = true
            paused = false
            player.stop()
            delayTimer.stop()
            --current // doNext will increment it again
        }
        function start() {
            if(model.length <= 0 || !stopped)
                return
            stopped = false
            paused = false
            doNext()
        }
//        function pause() {
//        }

        property bool stopped: true
        property bool paused: false
        property int current: -1
        function doPlay(url)
        {
            player.source = url
            player.play()
        }
        function doShowText(txt)
        {
            phraseTextControl.text = txt
            doNext()
        }

        function doDelay(duration)
        {
            delayTimer.interval = duration
            delayTimer.start()
        }
        function doNext() {
            if(audioController.stopped || model.length <= 0)
                return
            ++audioController.current
            if(audioController.current < 0
                    || audioController.model.length <= audioController.current)
            {
                audioController.current = 0
            }
            if(audioController.model[audioController.current].execute)
                audioController.model[audioController.current].execute(audioController)
        }

        function makeExecutor(func, arg) {
            return Qt.createQmlObject('import QtQuick 2.2; QtObject { function execute(controller) { controller.' + func + '("' + arg +'"); } }', audioController, '');
        }

        property list<QtObject> model: [QtObject{}]

        // delay timer
        Timer {
            id: delayTimer
            repeat: false
            onTriggered: {
                audioController.doNext()
            }
        }

        Audio {
            id: player
            onStopped: {
                audioController.doNext()
            }
            onError: {
                console.log('error playing ' + source)
                audioController.doNext()
            }
        }
    }

}
