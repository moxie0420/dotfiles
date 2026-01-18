pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

import qs.layers
import qs.modules.osd
import qs.services

ShellRoot {
  Variants {
    model: Quickshell.screens
    Scope {
      id: scope
      required property ShellScreen modelData
      PseudoReserved {
        modelData: scope.modelData
      }
      Layershell {
        modelData: scope.modelData
      }
    }
  }

  LazyLoader {
    activeAsync: Audio.shouldShowOsd
    Osd {}
  }

  LazyLoader {

  }

  Connections {
    function onReloadCompleted() {
      Quickshell.inhibitReloadPopup();
    }
    function onReloadFailed() {
      Quickshell.inhibitReloadPopup();
    }
    target: Quickshell
  }
}
