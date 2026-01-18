import QtQuick
import QtQuick.Layouts

import qs.components
import qs.services

Repeater {
  model: [
    {
      text: "󰐥",
      action: event => Dat.SessionActions.poweroff()
    },
    {
      text: "󰜉",
      action: event => Dat.SessionActions.reboot()
    },
    {
      text: "󰤄",
      action: event => Dat.SessionActions.suspend()
    },
  ]

  delegate: Rectangle {
    id: dot

    required property var modelData

    Layout.alignment: Qt.AlignCenter
    clip: true
    color: Colors.current.pine
    implicitHeight: this.implicitWidth
    implicitWidth: 28
    radius: this.implicitWidth

    MouseArea {
      layerColor: Colors.current.text
      onClicked: mevent => dot.modelData.action(mevent)
    }

    Text {
      anchors.centerIn: parent
      color: Colors.current.text
      font.bold: true
      font.pointSize: 12
      text: dot.modelData.text
    }
  }
}
