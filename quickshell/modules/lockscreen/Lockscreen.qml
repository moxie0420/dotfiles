pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland

Scope {
  id: root

  LockContext {
    id: lockContext
    onUnlocked: lockscreen.locked = false;
  }

  WlSessionLock {
    id: lockscreen

    WlSessionLockSurface {
      LockSurface {
        anchors.fill: parent
				context: lockContext
      }
    }
  }
}
