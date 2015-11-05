import QtQuick 2.0
import "../global.js" as Utils

Item {
  id: root
  width: Utils.scaled(24)
  height: Utils.scaled(24)

  Rectangle {
    id: bar1
    x: Utils.scaled(2)
    y: Utils.scaled(5)
    width: Utils.scaled(20)
    height: Utils.scaled(2)
    antialiasing: true
  }

  Rectangle {
    id: bar2
    x: Utils.scaled(2)
    y: Utils.scaled(10)
    width: Utils.scaled(20)
    height: Utils.scaled(2)
    antialiasing: true
  }

  Rectangle {
    id: bar3
    x: Utils.scaled(2)
    y: Utils.scaled(15)
    width: Utils.scaled(20)
    height: Utils.scaled(2)
    antialiasing: true
  }

  property int animationDuration: 350

  state: "menu"
  states: [
    State {
      name: "menu"
    },

    State {
      name: "back"
      PropertyChanges { target: root; rotation: 180 }
      PropertyChanges { target: bar1; rotation: 45; width: Utils.scaled(13); x: Utils.scaled(9.5); y: Utils.scaled(8) }
      PropertyChanges { target: bar2; width: Utils.scaled(17); x: Utils.scaled(3); y: Utils.scaled(12) }
      PropertyChanges { target: bar3; rotation: -45; width: Utils.scaled(13); x: Utils.scaled(9.5); y: Utils.scaled(16) }
    }
  ]

  transitions: [
    Transition {
      RotationAnimation { target: root; direction: RotationAnimation.Clockwise; duration: animationDuration; easing.type: Easing.InOutQuad }
      PropertyAnimation { target: bar1; properties: "rotation, width, x, y"; duration: animationDuration; easing.type: Easing.InOutQuad }
      PropertyAnimation { target: bar2; properties: "rotation, width, x, y"; duration: animationDuration; easing.type: Easing.InOutQuad }
      PropertyAnimation { target: bar3; properties: "rotation, width, x, y"; duration: animationDuration; easing.type: Easing.InOutQuad }
    }
  ]
}
