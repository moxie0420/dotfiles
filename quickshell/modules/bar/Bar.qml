import QtQuick
import QtQuick.Layouts

import qs.components
import qs.services

import "./widgets"

RowLayout {
  id: root

  required property BarState barstate

  // Left
  Item {
    Layout.fillHeight: true
    Layout.fillWidth: true

    RowLayout {
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter

      WorkspaceIndicator {
        Layout.leftMargin: 5
        barstate: root.barstate
      }

      MprisDot {
        implicitHeight: 20
        implicitWidth: 20
      }

      // RecordingDot {
      //   implicitHeight: 20
      //   implicitWidth: 20
      // }
    }
  }

  // Center
  Item {
    Layout.fillHeight: true
    Layout.fillWidth: true

    FormattedClock {
      MouseArea {
        anchors.fill: parent

        onClicked: mevent => {
          if (root.barstate.barState == "EXPANDED") {
            root.barstate.barState = "FULLY_EXPANDED";
            return;
          }

          root.barstate.barState = "EXPANDED";
        }
      }
    }
  }

  // Right
  Item {
    Layout.fillHeight: true
    Layout.fillWidth: true

    RowLayout {
      anchors.bottom: parent.bottom
      anchors.right: parent.right
      anchors.top: parent.top
      layoutDirection: Qt.RightToLeft
      spacing: 8

      Text {
        Layout.fillWidth: false
        // little arrow to toggle notch expand states
        Layout.rightMargin: 5
        color: Colors.current.pine
        font.pointSize: 11
        text: (root.barstate.barState == "FULLY_EXPANDED") ? "" : ""
        verticalAlignment: Text.AlignVCenter

        MouseArea {
          anchors.fill: parent

          onClicked: mevent => {
            if (root.barstate.barState == "EXPANDED") {
              root.barstate.barState = "FULLY_EXPANDED";
              return;
            }

            root.barstate.barState = "EXPANDED";
          }
        }
      }

      Battery {
        implicitHeight: 20
        radius: 20

        barstate: root.barstate
      }

      Volume {
        implicitHeight: 20
        radius: 20
      }

      BrightnessDot {
        implicitHeight: 20
        implicitWidth: 20
      }
    }
  }
}
