pragma Singleton

import Quickshell
import QtQuick

Singleton {
  property alias date: sysClock.date

  SystemClock {
    id: sysClock
    precision: SystemClock.Seconds
  }
}
