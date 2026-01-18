pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell.Services.Mpris
import Quickshell

import qs.services

Item {
  Text {
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 5
    anchors.horizontalCenter: parent.horizontalCenter
    color: Colors.current.text
    text: "Play some music"
  }

  SwipeView {
    id: list

    anchors.fill: parent
    orientation: Qt.Vertical

    Repeater {
      model: ScriptModel {
        values: [...Mpris.players.values]
      }

      MprisItem {
        id: rect

        property int increaseOrDecrease: 0
        required property int index
        required property MprisPlayer modelData
        property bool readyToShow: false

        player: modelData
      }
    }
  }

  PageIndicator {
    id: pageIndicator

    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    count: list.count
    currentIndex: list.currentIndex
    interactive: false
    rotation: 90
    visible: this.count > 1

    delegate: Rectangle {
      id: smallrect

      required property int index

      color: (index == list.currentIndex) ? "white" : Colors.withAlpha("white", 0.5)
      height: this.width
      radius: 6
      width: 6

      Behavior on color {
        ColorAnimation {
          duration: 500
        }
      }
    }
  }
}
