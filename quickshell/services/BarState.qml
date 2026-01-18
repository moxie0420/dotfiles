import QtQuick
import Quickshell.Wayland

import qs.services

QtObject {
  id: root

  required property var modelData
  property string actWinName: ToplevelManager?.activeToplevel.title ?? "Desktop"
  property string barState: "EXPANDED"

  property bool barHovered: false

  onActWinNameChanged: {
    if (Config.data.reservedShell) return;

    if (root.actWinName == "Desktop" && barState == "COLLAPSED") {
      root.barState = "EXPANDED";
    } else if (barState == "EXPANDED" && !barHovered) {
      root.barState = "COLLAPSED";
    }
  }
}
