import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
  required property ShellScreen modelData
  screen: modelData

  anchors.left: true
  anchors.right: true
  anchors.top: true
  color: "transparent"
  exclusionMode: ExclusionMode.Auto
  focusable: false
  implicitHeight: 20
  WlrLayershell.layer: WlrLayer.Bottom
  WlrLayershell.namespace: "pineish.bar.pseudotop"
  surfaceFormat.opaque: false
}

