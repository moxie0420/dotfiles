pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import qs.modules.bar
import qs.services

PanelWindow {
  id: root

  required property ShellScreen modelData
  screen: modelData

  anchors.left: true
  anchors.right: true
  anchors.top: true

  exclusionMode: ExclusionMode.Ignore
  focusable: false

  implicitHeight: screen.height * 0.65
  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.namespace: "pineish.bar"

  surfaceFormat.opaque: false
  color: "transparent"

  mask: Region {
    item: barRect
  }

  BarState {
    id: stateVar
    modelData: root.modelData
  }

  Rectangle {
    id: barRect

    readonly property int baseHeight: 1
    readonly property int baseWidth: 200
    readonly property int expandedHeight: 22
    readonly property int expandedWidth: 1080
    readonly property int fullHeight: 250
    readonly property int fullWidth: this.expandedWidth

    anchors.horizontalCenter: parent.horizontalCenter
    bottomLeftRadius: 20
    bottomRightRadius: 20
    clip: true

    state: stateVar.barState

    color: Colors.withAlpha(
      Colors.current.base,
      (
        stateVar.actWinName === "desktop" &&
        stateVar.barState != "FULLY_EXPANDED"
      ) ? 0.50 : 0.75
    )

    Behavior on color {
      ColorAnimation {
        duration: Easings.standardTime
      }
    }

    states: [
      State {
        name: "COLLAPSED"
        PropertyChanges {
          expandedPane.opacity: 0
          expandedPane.visible: false
          barRect.height: barRect.baseHeight
          barRect.opacity: 0
          barRect.width: barRect.baseWidth
          topBar.opacity: 0
          topBar.visible: false
        }
      },

      State {
        name: "EXPANDED"
        PropertyChanges {
          expandedPane.opacity: 0
          expandedPane.visible: false
          barRect.height: barRect.expandedHeight
          barRect.opacity: 1
          barRect.width: barRect.expandedWidth
          topBar.opacity: 1
          topBar.visible: true
        }
      },

      State {
        name: "FULLY_EXPANDED"
        PropertyChanges {
          expandedPane.opacity: 1
          expandedPane.visible: true
          barRect.height: barRect.fullHeight
          barRect.opacity: 1
          barRect.width: barRect.fullWidth
          topBar.opacity: 1
          topBar.visible: true
        }
      }
    ]

    transitions: [
      Transition {
        from: "COLLAPSED"
        to: "EXPANDED"

        SequentialAnimation {
          PropertyAction {
            property: "visible"
            target: topBar
          }

          PropertyAction {
            property: "opacity"
            target: barRect
          }

          ParallelAnimation {
            NumberAnimation {
              duration: Easings.standardTime * 2
              easing.bezierCurve: Easings.standard
              property: "opacity"
              target: topBar
            }

            NumberAnimation {
              duration: Easings.standardDecelTime
              easing.bezierCurve: Easings.standardDecel
              properties: "width, opacity, height"
              target: barRect
            }
          }
        }
      },
      Transition {
        from: "EXPANDED"
        to: "COLLAPSED"

        SequentialAnimation {
          ParallelAnimation {
            NumberAnimation {
              duration: Easings.standardAccelTime
              easing.bezierCurve: Easings.standardAccel
              properties: "width, height"
              target: barRect
            }

            NumberAnimation {
              duration: Easings.standardAccelTime
              easing.bezierCurve: Easings.standardAccel
              property: "opacity"
              target: topBar
            }
          }

          PropertyAction {
            property: "visible"
            target: topBar
          }

          PropertyAction {
            property: "opacity"
            target: barRect
          }
        }
      },
      Transition {
        from: "EXPANDED"
        to: "FULLY_EXPANDED"

        SequentialAnimation {
          PropertyAction {
            property: "visible"
            target: expandedPane
          }

          ParallelAnimation {
            NumberAnimation {
              duration: Easings.standardDecelTime
              easing.bezierCurve: Easings.standardDecel
              property: "height"
              target: barRect
            }

            NumberAnimation {
              duration: Easings.standardTime * 3
              easing.bezierCurve: Easings.standard
              property: "opacity"
              target: expandedPane
            }
          }
        }
      },
      Transition {
        id: fExpToExpTS

        from: "FULLY_EXPANDED"
        to: "EXPANDED"

        SequentialAnimation {
          ParallelAnimation {
            NumberAnimation {
              duration: Easings.standardTime
              easing.bezierCurve: Easings.standard
              property: "height"
              target: barRect
            }

            NumberAnimation {
              duration: Easings.standardTime
              easing.bezierCurve: Easings.standard
              property: "opacity"
              target: expandedPane
            }
          }

          PropertyAction {
            property: "visible"
            target: expandedPane
          }
        }
      },
      // sometimes due to the will of kuru kuru this happens
      // so just make sure it isn't very jagged
      Transition {
        from: "COLLAPSED"
        reversible: true
        to: "FULLY_EXPANDED"

        NumberAnimation {
          duration: Easings.emphasizedTime
          easing.bezierCurve: Easings.emphasized
          properties: "height, opacity, width"
          target: barRect
        }
      }
    ]


    MouseArea {
      id: barArea

      property real prevY: 0
      readonly property real sensitivity: 0.80
      property bool tracing: false
      property real velocity: 0

      function revealOrCollapse() {
        if (fExpToExpTS.running) return;

        if (stateVar.barState == "FULLY_EXPANDED" || stateVar.actWinName == "desktop" || Config.data.reservedShell) {
          return;
        }

        if (barArea.containsMouse) {
          stateVar.barState = "EXPANDED";
        } else {
          stateVar.barState = "COLLAPSED";
        }
      }

      anchors.fill: parent
      hoverEnabled: true

      Component.onCompleted: fExpToExpTS.runningChanged.connect(barArea.revealOrCollapse)
      onContainsMouseChanged: {
        stateVar.barHovered = barArea.containsMouse;
        barArea.revealOrCollapse();
      }

      onPositionChanged: mevent => {
        if (!tracing)
          return;

        barArea.velocity = barArea.prevY - mevent.y;
        barArea.prevY = mevent.y;

        // swipe down behaviour
        if (velocity <= -barArea.sensitivity) {
          stateVar.barState = "FULLY_EXPANDED";
          barArea.tracing = false;
          barArea.velocity = 0;
        }

        // swipe up behaviour
        if (velocity >= barArea.sensitivity) {
          stateVar.barState = "EXPANDED";
          barArea.tracing = false;
          barArea.velocity = 0;
        }
      }

      onPressed: mevent => {
        barArea.tracing = true;
        barArea.prevY = mevent.y;
        barArea.velocity = 0;
      }

      onReleased: mevent => {
        barArea.tracing = false;
        barArea.velocity = 0;
      }

      ColumnLayout {
        anchors.centerIn: parent
        anchors.fill: parent
        spacing: 8

        Bar {
          id: topBar

          Layout.alignment: Qt.AlignTop
          Layout.fillWidth: true
          Layout.maximumHeight: barRect.expandedHeight
          Layout.minimumHeight: barRect.expandedHeight - 10

          barstate: stateVar
        }

        Primary {
          id: expandedPane
          Layout.fillHeight: true
          Layout.fillWidth: true

          actWinName: stateVar.actWinName
          barState: stateVar.barState
        }
      }
    }
  }
}
