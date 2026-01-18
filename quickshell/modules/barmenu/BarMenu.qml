pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.components as Comp
import qs.services

Item {
  id: root

  required property string actWinName
  required property string barState

  RowLayout {
    anchors.fill: parent
    spacing: 8

    // page indicator
    Rectangle {
      Layout.leftMargin: 8
      color: Colors.current.surface
      implicitHeight: tabCols.height + 10
      implicitWidth: 28
      radius: 20

      ColumnLayout {
        id: tabCols

        anchors.verticalCenter: parent.verticalCenter
        spacing: 10
        width: parent.width

        Repeater {
          model: ["󰋜", "󰃭", "󱄅", "󰎇", "󰒓"]

          Item {
            id: tabDot

            required property int index
            required property string modelData

            Layout.alignment: Qt.AlignCenter
            implicitHeight: this.implicitWidth
            implicitWidth: 20

            Text {
              id: dotText

              anchors.centerIn: parent
              color: Colors.current.rose
              font.pointSize: 11
              state: (swipeArea.currentIndex == tabDot.index) ? "ACTIVE" : "INACTIVE"
              text: tabDot.modelData

               states: [
                State {
                  name: "ACTIVE"
                  PropertyChanges {
                    dotText.scale: 1.6
                  }
                },
                State {
                  name: "INACTIVE"

                  PropertyChanges {
                    dotText.scale: 1
                  }
                }
              ]

              transitions: [
                Transition {
                  from: "INACTIVE"
                  to: "ACTIVE"

                  NumberAnimation {
                    duration: Easings.standardAccelTime
                    easing.bezierCurve: Easings.standardAccel
                    property: "scale"
                  }
                },
                Transition {
                  from: "ACTIVE"
                  to: "INACTIVE"

                  NumberAnimation {
                    duration: Easings.standardDecelTime
                    easing.bezierCurve: Easings.standardDecel
                    property: "scale"
                  }
                }
              ]
            }

            Comp.MouseArea {
              layerRadius: parent.width
              layerRect.scale: dotText.scale
              onClicked: swipeArea.setCurrentIndex(tabDot.index)
            }
          }
        }
      }
    }

    Rectangle {
      id: swipeRect

      Layout.fillHeight: true
      Layout.fillWidth: true

      clip: true
      color: Colors.current.surface
      radius: 20

      SwipeView {
        id: swipeArea
        anchors.fill: parent
        orientation: Qt.Horizontal

        Component.onCompleted: () => {
          Globals.swipeIndexChanged.connect(() => {
            if (swipeArea.currentIndex != Globals.swipeIndex) {
              swipeArea.currentIndex = Globals.swipeIndex;
            }
          })
        }

        onCurrentIndexChanged: () => {
          if (swipeArea.currentIndex != Globals.swipeIndex) {
            Globals.swipeIndex = swipeArea.currentIndex;
          }
        }

        // menu panels go here
        HomeView {
          height: swipeRect.height
          width: swipeRect.width

          actWinName: root.actWinName
          barState: root.barState
        }

        CalendarView {
          height: swipeRect.height
          width: swipeRect.width
        }

        SystemView {
          height: swipeRect.height
          width: swipeRect.width
        }

        MusicView {
          height: swipeRect.height
          width: swipeRect.width
        }

        SettingsView {
          height: swipeRect.height
          width: swipeRect.width
        }
      }
    }
  }
}
