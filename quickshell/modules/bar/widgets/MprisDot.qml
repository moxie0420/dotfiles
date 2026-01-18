import QtQuick
import Quickshell.Services.Mpris

import qs.components
import qs.services

Item {
  visible: Mpris.players.values.length

  Text {
    id: icon

    anchors.centerIn: parent
    color: Colors.current.foam
    font.pointSize: 11
    rotation: Globals.mprisDotRotation
    text: "󰽰"

    // MAKE SURE THIS IS THE SAME AS MPRIS ITEM's
    Behavior on rotation {
      NumberAnimation {
        duration: 500
        easing.type: Easing.Linear
      }
    }
  }

  MouseArea {
    acceptedButtons: Qt.LeftButton
    layerColor: Colors.current.foam

    onClicked: mevent => {
      if (Globals.barState == "FULLY_EXPANDED" && Globals.swipeIndex == 3) {
        Globals.barState = "EXPANDED";
      } else {
        Globals.barState = "FULLY_EXPANDED";
        Globals.swipeIndex = 3;
      }
    }
  }
}
