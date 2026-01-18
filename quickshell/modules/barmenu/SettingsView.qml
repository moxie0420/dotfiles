pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.components
import qs.services

Item {
  ColumnLayout {
    anchors.fill: parent
    anchors.topMargin: this.spacing
    spacing: 3

    Item {
      Layout.fillWidth: true
      Layout.leftMargin: 20
      Layout.rightMargin: 20
      implicitHeight: 18

      RowLayout {
        id: tabLay

        property int activeIndex: Globals.settingsTabIndex

        anchors.fill: parent

        Repeater {
          model: ["Power", "Audio"]

          Item {
            id: tabRect

            required property int index
            required property string modelData

            Layout.fillHeight: true
            Layout.fillWidth: true
            state: (index == tabLay.activeIndex) ? "ACTIVE" : "INACTIVE"

            states: [
              State {
                name: "ACTIVE"

                PropertyChanges {
                  bgRect.opacity: 1
                  tabText.opacity: 1
                }
              },
              State {
                name: "INACTIVE"

                PropertyChanges {
                  bgRect.opacity: 0
                  tabText.opacity: 0.8
                }
              }
            ]
            transitions: [
              Transition {
                from: "INACTIVE"
                to: "ACTIVE"

                NumberAnimation {
                  duration: Easings.emphasizedAccelTime
                  easing.bezierCurve: Easings.emphasizedAccel
                  properties: "bgRect.opacity,tabText.opacity"
                }
              },
              Transition {
                from: "ACTIVE"
                to: "INACTIVE"

                NumberAnimation {
                  duration: Easings.emphasizedDecelTime
                  easing.bezierCurve: Easings.emphasizedDecel
                  properties: "bgRect.opacity,tabText.opacity"
                }
              }
            ]

            Rectangle {
              id: bgRect

              anchors.centerIn: parent
              color: Colors.current.highlightHigh
              height: tabRect.height
              radius: 10
              width: tabText.contentWidth + 20
            }

            Text {
              id: tabText

              anchors.centerIn: parent
              color: Colors.current.text
              horizontalAlignment: Text.AlignHCenter
              text: parent.modelData
              verticalAlignment: Text.AlignVCenter

              Behavior on opacity {
                NumberAnimation {
                  duration: Easings.emphasizedTime
                  easing.bezierCurve: Easings.emphasized
                }
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                // TODO hover animation
                // onContainsMouseChanged: parent.opacity += (containsMouse)? 0.2 : -0.2
                onClicked: mevent => {
                  Globals.settingsTabIndex = tabRect.index;
                }
              }
            }
          }
        }
      }
    }

    StackLayout {
      Layout.fillHeight: true
      Layout.fillWidth: true
      currentIndex: tabLay.activeIndex

      PowerTab {
        Layout.fillHeight: true
        Layout.fillWidth: true
        opacity: visible ? 1 : 0

        Behavior on opacity {
          NumberAnimation {
            duration: Easings.standardAccelTime
            easing.bezierCurve: Easings.standardAccel
          }
        }
      }

      AudioTab {
        Layout.fillHeight: true
        Layout.fillWidth: true
        opacity: visible ? 1 : 0

        Behavior on opacity {
          NumberAnimation {
            duration: Easings.emphasizedAccelTime
            easing.bezierCurve: Easings.emphasizedAccel
          }
        }
      }
    }
  }
}
