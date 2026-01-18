import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

import qs.services
import qs.components

Rectangle {
  id: root

  required property BarState barstate

  readonly property bool batCharging: UPower.displayDevice.state == UPowerDeviceState.Charging
  readonly property string batIcon: batIcons[10 - Math.round(batPercentage * 10)]
  readonly property list<string> batIcons: ["󰁹", "󰂂", "󰂁", "󰂀", "󰁿", "󰁾", "󰁽", "󰁼", "󰁻", "󰁺", "󰂃"]
  readonly property real batPercentage: UPower.displayDevice.percentage
  readonly property string chargeIcon: batIcons[10 - chargeIconIndex]

  property int chargeIconIndex: 0
  property bool hasBattery: UPower.displayDevice.percentage > 0
  property string profileIcon: switch (PowerProfiles.profile) {
    case 0:
      "";
      break;
    case 1:
      "";
      break;
    case 2:
      "";
      break;
  }

  Layout.minimumWidth: contentRow.width ? contentRow.width : 1
  color: Colors.current.surface

  Behavior on Layout.minimumWidth {
    NumberAnimation {
      duration: 150
      easing.type: Easing.Linear
    }
  }

  RowLayout {
    id: contentRow

    anchors.centerIn: parent
    height: parent.height
    spacing: 0

    Item {
      Layout.fillHeight: true
      implicitWidth: batText.contentWidth + 16
      visible: root.hasBattery

      Text {
        id: batText

        anchors.centerIn: parent
        color: Colors.current.text
        font.pointSize: 11
        text: Math.round(root.batPercentage * 100) + "%"
        visible: UPower.displayDevice.percentage > 0
      }
    }

    Rectangle {
      Layout.fillHeight: true
      color: Colors.current.pine
      implicitWidth: this.height
      radius: this.height

      Text {
        anchors.centerIn: parent
        color: Colors.current.text
        font.pointSize: (mArea.containsMouse || !root.hasBattery) ? 9 : 11
        text: (mArea.containsMouse || !root.hasBattery) ? root.profileIcon : ((root.batCharging) ? root.chargeIcon : root.batIcon)
      }
    }
  }

  Timer {
    interval: 600
    repeat: true
    running: root.batCharging && (root.barstate.barState != "COLLAPSED")

    onTriggered: () => {
      root.chargeIconIndex = root.chargeIconIndex % 10;
      root.chargeIconIndex += 1;
    }
  }

  MouseArea {
    id: mArea

    layerColor: Colors.current.text

    onClicked: {
      if (root.barstate.barState == "FULLY_EXPANDED" && Globals.swipeIndex == 4 && Globals.settingsTabIndex == 0) {
        root.barstate.barState = "EXPANDED";
      } else {
        root.barstate.barState = "FULLY_EXPANDED";
        Globals.swipeIndex = 4;
        Globals.settingsTabIndex = 0;
      }
    }
  }
}
