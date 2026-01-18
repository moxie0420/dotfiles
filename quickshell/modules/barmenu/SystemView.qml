pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

import qs.components
import qs.services

Item {
  id: root

  property int index: SwipeView.index
  property bool isCurrent: SwipeView.isCurrentItem

  RowLayout {
    anchors.fill: parent
    anchors.margins: 10
    anchors.rightMargin: 5
    spacing: 5

    Rectangle {
      Layout.fillHeight: true
      Layout.fillWidth: true
      clip: true
      color: Colors.current.base
      radius: 10

      Image {
        id: nixLogo

        fillMode: Image.PreserveAspectCrop
        height: this.width
        layer.enabled: true
        opacity: 0.9
        rotation: 0
        source: "../../Assets/nix-snowflake-white.svg"
        width: parent.height
        x: -(this.width / 2.5)

        layer.effect: MultiEffect {
          colorization: 1
          colorizationColor: Colors.current.rose
        }
        Behavior on rotation {
          NumberAnimation {
            duration: 500
            easing.type: Easing.Linear
          }
        }

        Timer {
          interval: 500
          repeat: true
          running: Globals.barState == "FULLY_EXPANDED" && root.isCurrent
          triggeredOnStart: true

          onTriggered: parent.rotation = (parent.rotation + 3) % 360
        }
      }

      ColumnLayout { // area to the right of the image
        id: rightArea

        anchors.bottom: parent.bottom
        anchors.left: nixLogo.right
        anchors.margins: 5
        anchors.right: parent.right
        anchors.top: parent.top

        Rectangle {
          id: monitorRect

          Layout.fillHeight: true
          Layout.fillWidth: true
          clip: true
          color: Colors.current.surface
          radius: 10

          RowLayout {
            anchors.fill: parent
            anchors.margins: 5

            Text {
              Layout.leftMargin: 45
              Layout.fillHeight: true
              color: Colors.current.pine
              font.pointSize: 64
              horizontalAlignment: Text.AlignHCenter
              verticalAlignment: Text.AlignVCenter
              text: ""
            }

            Item {
              Layout.maximumWidth: this.height
              Layout.fillWidth: true
              Layout.fillHeight: true
              implicitHeight: this.width

              GridLayout {
                anchors.fill: parent
                columns: 3
                rows: 3

                Repeater {
                  model: 9

                  Rectangle {
                    required property int index

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: (Hyprland.focusedWorkspace?.id == this.index + 1) ? Colors.current.pine : Colors.current.highlightHigh
                    radius: this.width

                    MouseArea {
                      layerColor: Colors.current.pine
                      onClicked: Hyprland.dispatch("workspace " + (parent.index + 1))
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    Item {
      Layout.fillHeight: true
      implicitWidth: 30

      ColumnLayout {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width

        SessionDots {}
      }
    }
  }
}
