pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.SystemTray
import Quickshell

import qs.services

Item {
  id: root

  required property string actWinName
  required property string barState

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 3
    spacing: 0

    Rectangle {
      Layout.fillHeight: true
      Layout.fillWidth: true
      color: Colors.current.surface
      radius: 20

      StackView {
        id: stack
        anchors.fill: parent

        initialItem: Greeter {
          height: stack.height
          width: stack.width
        }

        popEnter: Transition {
          ParallelAnimation {
            NumberAnimation {
              duration: Easings.emphasizedDecelTime
              easing.bezierCurve: Easings.emphasizedDecel
              from: 0
              property: "opacity"
              to: 1
            }

            NumberAnimation {
              duration: Easings.emphasizedDecelTime
              easing.bezierCurve: Easings.emphasizedDecel
              from: -100
              property: "y"
            }
          }
        }

        popExit: Transition {
          ParallelAnimation {
            NumberAnimation {
              duration: Easings.emphasizedTime
              easing.bezierCurve: Easings.emphasized
              from: 1
              property: "opacity"
              to: 0
            }

            NumberAnimation {
              duration: Easings.emphasizedAccelTime
              easing.bezierCurve: Easings.emphasizedAccel
              property: "y"
              to: 100
            }
          }
        }

        pushEnter: Transition {
          ParallelAnimation {
            NumberAnimation {
              duration: Easings.emphasizedTime
              easing.bezierCurve: Easings.emphasized
              from: 0
              property: "opacity"
              to: 1
            }

            NumberAnimation {
              duration: Easings.emphasizedDecelTime
              easing.bezierCurve: Easings.emphasizedDecel
              from: 100
              property: "y"
            }
          }
        }

        pushExit: Transition {
          ParallelAnimation {
            NumberAnimation {
              duration: Easings.emphasizedTime
              easing.bezierCurve: Easings.emphasized
              from: 1
              property: "opacity"
              to: 0
            }
          }

          NumberAnimation {
            duration: Easings.emphasizedAccelTime
            easing.bezierCurve: Easings.emphasizedAccel
            property: "y"
            to: -100
          }
        }

        replaceEnter: Transition {
          ParallelAnimation {
            PropertyAnimation {
              duration: 0
              property: "opacity"
              to: 1
            }

            NumberAnimation {
              duration: Easings.emphasizedDecelTime
              easing.bezierCurve: Easings.emphasizedDecel
              from: 100
              property: "y"
            }
          }
        }

        replaceExit: Transition {
          NumberAnimation {
            duration: Easings.emphasizedAccelTime
            easing.bezierCurve: Easings.emphasizedAccel
            from: 1
            property: "opacity"
            to: 0
          }
        }

        Component.onCompleted: {
          root.barStateChanged.connect(() => {
            if (root.barState != "FULLY_EXPANDED")
              stack.pop();
          });
        }
      }
    }

    Item {
      Layout.fillWidth: true
      implicitHeight: 20
      visible: SystemTray.items.values.length != 0

      Behavior on implicitHeight {
        NumberAnimation {
          duration: Easings.emphasizedTime
          easing.bezierCurve: Easings.emphasized
        }
      }

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        Item {
          Layout.fillHeight: true
          Layout.fillWidth: true

          ListView {
            id: trayItemRow

            anchors.fill: parent
            orientation: ListView.Horizontal
            snapMode: ListView.SnapToItem
            spacing: 10

            add: Transition {
              SequentialAnimation {
                NumberAnimation {
                  duration: 0
                  property: "opacity"
                  to: 0
                }

                PauseAnimation {
                  duration: addDisAni.duration / 2
                }

                NumberAnimation {
                  duration: Easings.emphasizedTime
                  easing.bezierCurve: Easings.emphasized
                  from: 0
                  property: "opacity"
                  to: 1
                }
              }
            }

            addDisplaced: Transition {
              SequentialAnimation {
                NumberAnimation {
                  id: addDisAni

                  duration: Easings.emphasizedDecelTime
                  easing.bezierCurve: Easings.emphasizedDecel
                  properties: "x"
                }
              }
            }

            delegate: TrayItem {
              stackView: stack
            }

            model: ScriptModel {
              values: [...SystemTray.items.values]
            }

            remove: Transition {
              NumberAnimation {
                id: removeAni

                duration: Easings.emphasizedTime
                easing.bezierCurve: Easings.emphasized
                from: 1
                property: "opacity"
                to: 0
              }
            }

            removeDisplaced: Transition {
              SequentialAnimation {
                PauseAnimation {
                  duration: removeAni.duration / 2
                }

                NumberAnimation {
                  duration: Easings.emphasizedDecelTime
                  easing.bezierCurve: Easings.emphasizedDecel
                  properties: "x"
                }
              }
            }

            onCountChanged: stack.pop()
          }
        }

        Item {
          Layout.fillHeight: true
          implicitWidth: uptimeText.contentWidth + 10
          Text {
            id: uptimeText

            anchors.centerIn: parent
            color: Colors.current.text
            font.pointSize: 10
            text: Resources.uptime
          }
        }
      }
    }
  }
}
