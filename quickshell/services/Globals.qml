pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.services

Singleton {
  id: root

  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

  property string hostName: "nixUwU"

  property real mprisDotRotation: 0

  // SettingsView State
  // 0 => Power
  // 1 => Audio
  // 2 => Network
  property int settingsTabIndex: 0

  // Central Panel SwipeView stuff
  // 0 => Home
  // 1 => Calendar
  // 2 => System
  // 3 => Mpris
  // 4 => SettingsView
  property int swipeIndex: 0

  Component.onCompleted: {
    Config.data.reservedShellChanged.connect(() => {
      if (barState == "COLLAPSED" && Config.data.reservedShell)
        barState = "EXPANDED";
    });
  }

}
