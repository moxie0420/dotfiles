import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.components
import qs.services

Rectangle {
  id: root

  Layout.minimumWidth: swiper.currentItem?.contentWidth + 20
  clip: true
  color: Colors.current.surface

  Behavior on Layout.minimumWidth {
    NumberAnimation {
      duration: 150
      easing.type: Easing.Linear
    }
  }

  SwipeView {
    id: swiper

    anchors.fill: parent
    orientation: Qt.Horizontal

    Text {
      color: Colors.current.text
      font.pointSize: 11
      height: root.height
      horizontalAlignment: Text.AlignHCenter
      text: Math.round(Audio.sinkVolume * 100) + "%" + " " + Audio.sinkIcon
      verticalAlignment: Text.AlignVCenter
      width: root.width

      MouseArea {
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        clickOpacity: 0.2
        layerColor: Colors.current.text
        layerRadius: root.radius

        onClicked: mouse => {
          switch (mouse.button) {
          case Qt.MiddleButton:
            Audio.toggleMute(Audio.sink);
            break;
          case Qt.LeftButton:
            if (Globals.barState == "FULLY_EXPANDED" && Globals.swipeIndex == 4 && Globals.settingsTabIndex == 1) {
              Globals.barState = "EXPANDED";
            } else {
              Globals.barState = "FULLY_EXPANDED";
              Globals.swipeIndex = 4;
              Globals.settingsTabIndex = 1;
            }
            break;
          }
        }
        onWheel: event => Audio.wheelAction(event, Audio.sink)
      }
    }

    Text {
      color: Colors.current.text
      font.pointSize: 11
      height: root.height
      horizontalAlignment: Text.AlignHCenter
      text: Math.round(Audio.sourceVolume * 100) + "%" + " " + Audio.sourceIcon
      verticalAlignment: Text.AlignVCenter
      width: root.width

      MouseArea {
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        clickOpacity: 0.2
        layerColor: Colors.current.text
        layerRadius: root.radius

        onClicked: mouse => {
          switch (mouse.button) {
          case Qt.MiddleButton:
            Audio.toggleMute(Audio.source);
            break;
          case Qt.LeftButton:
            if (Globals.barState == "FULLY_EXPANDED" && Globals.swipeIndex == 4 && Globals.settingsTabIndex == 1) {
              Globals.notchState = "EXPANDED";
            } else {
              Globals.notchState = "FULLY_EXPANDED";
              Globals.swipeIndex = 4;
              Globals.settingsTabIndex = 1;
            }
            break;
          }
        }
        onWheel: event => Audio.wheelAction(event, Audio.source)
      }
    }
  }
}
