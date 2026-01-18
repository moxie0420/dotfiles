pragma Singleton

import Quickshell
import QtQuick

Singleton {
  property var current: base

  property alias base: base
  property alias moon: moon
  property alias dawn: dawn

  function withAlpha(color: color, alpha: real): color {
    return Qt.rgba(color.r, color.g, color.b, alpha)
  }

  QtObject {
    id: base

    property color base:          "#191724"
    property color surface:       "#1f1d2e"
    property color overlay:       "#26233a"
    property color muted:         "#6e6a86"
    property color subtle:        "#908caa"
    property color text:          "#e0def4"

    property color love:          "#eb6f92"
    property color gold:          "#f6c177"
    property color rose:          "#ebbcba"
    property color pine:          "#31748f"
    property color foam:          "#9ccfd8"
    property color iris:          "#c4a7e7"

    property color highlightLow:  "#21202e"
    property color highlightMed:  "#403d52"
    property color highlightHigh: "#524f67"
  }


  QtObject {
    id: moon

    property color base:          "#232136"
    property color surface:       "#2a273f"
    property color overlay:       "#393552"
    property color muted:         "#6e6a86"
    property color subtle:        "#908caa"
    property color text:          "#e0def4"

    property color love:          "#eb6f92"
    property color gold:          "#f6c177"
    property color rose:          "#ea9a97"
    property color pine:          "#3e8fb0"
    property color foam:          "#9ccfd8"
    property color iris:          "#c4a7e7"

    property color highlightLow:  "#2a283e"
    property color highlightMed:  "#44415a"
    property color highlightHigh: "#56526e"
  }

  QtObject {
    id: dawn

    property color base:          "#faf4ed"
    property color surface:       "#fffaf3"
    property color overlay:       "#f2e9e1"
    property color muted:         "#9893a5"
    property color subtle:        "#797593"
    property color text:          "#575279"

    property color love:          "#b4637a"
    property color gold:          "#ea9d34"
    property color rose:          "#d7827e"
    property color pine:          "#286983"
    property color foam:          "#56949f"
    property color iris:          "#907aa9"

    property color highlightLow:  "#f4ede8"
    property color highlightMed:  "#dfdad9"
    property color highlightHigh: "#cecacd"
  }
}
