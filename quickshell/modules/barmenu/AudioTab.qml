import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

import qs.components
import qs.services

Rectangle {
  clip: true
  color: Colors.current.highlightHigh
  radius: 20

  ListView {
    anchors.fill: parent
    anchors.margins: 10
    spacing: 12

    delegate: AudioSlider {
      required property PwNode modelData

      implicitWidth: parent?.width ?? 0
      node: modelData
    }
    model: ScriptModel {
      id: sModel

      values: Pipewire.nodes.values.filter(node => node.audio).sort()
    }
  }

  PwObjectTracker {
    objects: sModel.values
  }
}
