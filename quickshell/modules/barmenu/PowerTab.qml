pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.UPower

import qs.components
import qs.services

Rectangle {
  color: Colors.current.highlightHigh
  radius: 20

  RowLayout {
    anchors.fill: parent
    spacing: 0

    Item {
      Layout.fillHeight: true
      Layout.fillWidth: true

      Rectangle {
        anchors.fill: parent
        color: Colors.current.surface
        radius: 20
      }

      ColumnLayout {
        id: infoCol

        anchors.fill: parent
        anchors.margins: (informationRect.visible) ? 0 : 10

        Item {
          Layout.fillHeight: true
          Layout.fillWidth: true
          clip: true

          RowLayout {
            anchors.fill: parent
            anchors.margins: 3
            spacing: 0

            Repeater {
              id: resourceRepeater

              readonly property real cpuUsage: (1 - (Resources.cpu.idleSec / Resources.cpu.totalSec))
              readonly property real memUsage: (1 - (Resources.mem.free / Resources.mem.total))

              model: [
                {
                  icon: "",
                  label: "Cpu"
                },
                {
                  icon: "",
                  label: "Mem"
                }
              ]

              delegate: Item {
                id: itemRoot

                required property int index
                required property var modelData
                property real usage: (index) ? resourceRepeater.memUsage : resourceRepeater.cpuUsage

                Layout.alignment: Qt.AlignCenter
                Layout.fillHeight: true
                implicitWidth: this.height

                CircularProgress {
                  anchors.centerIn: parent
                  degreeLimit: 290
                  lineWidth: 7
                  rotation: -189
                  size: parent.width
                  value: itemRoot.usage
                }

                Text {
                  anchors.centerIn: parent
                  color: Colors.current.pine
                  font.pointSize: 24
                  text: (parent.usage * 100).toFixed(0)
                }

                Rectangle {
                  anchors.bottom: parent.bottom
                  anchors.bottomMargin: this.anchors.rightMargin
                  anchors.right: parent.right
                  anchors.rightMargin: 5
                  color: Colors.current.pine
                  height: this.width
                  radius: this.width
                  width: 35

                  Text {
                    anchors.centerIn: parent
                    color: Colors.current.text
                    font.pointSize: 16
                    text: itemRoot.modelData.icon
                  }
                }
              }
            }
          }
        }

        Rectangle {
          id: informationRect

          // BATTERY information
          Layout.fillWidth: true
          color: Colors.current.highlightHigh
          implicitHeight: 28
          radius: 20
          topLeftRadius: 0
          topRightRadius: 0
          visible: UPower.displayDevice.percentage > 0

          PowerInfo {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
          }
        }
      }
    }

    Item {
      id: powerSliderRect

      Layout.margins: 3
      implicitHeight: parent.height - 14
      implicitWidth: 40

      Slider {
        id: slider

        anchors.fill: parent
        from: 0
        orientation: Qt.Vertical
        snapMode: Slider.SnapAlways
        stepSize: 1
        to: 2
        value: PowerProfiles.profile

        background: ColumnLayout {
          anchors.fill: parent
          spacing: 0

          Repeater {
            model: ["", "", ""]

            Item {
              required property int index
              required property string modelData

              Layout.alignment: Qt.AlignHCenter
              implicitHeight: this.implicitWidth
              implicitWidth: slider.width

              Text {
                anchors.centerIn: parent
                color: Colors.current.text
                text: parent.modelData
              }
            }
          }
        }
        handle: Rectangle {
          anchors.horizontalCenter: parent.horizontalCenter
          color: Colors.current.pine
          height: this.width
          radius: this.width
          visible: true
          width: slider.width
          y: slider.visualPosition * (slider.availableHeight - height)

          Behavior on y {
            NumberAnimation {
              duration: Easings.emphasizedTime
              easing.bezierCurve: Easings.emphasized
            }
          }

          Text {
            anchors.centerIn: parent
            color: Colors.current.text
            text: switch (PowerProfiles.profile) {
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
          }
        }

        onMoved: {
          PowerProfiles.profile = slider.value;
        }
      }
    }
  }
}
