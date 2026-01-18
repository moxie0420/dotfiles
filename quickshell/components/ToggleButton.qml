import QtQuick

import qs.components
import qs.services

Rectangle {
  id: root

  required property bool active
  property color activeColor: Colors.current.pine
  property color activeIconColor: Colors.current.text
  property alias icon: matIcon
  property alias mArea: mouseArea
  property color passiveColor: Colors.current.base
  property color passiveIconColor: Colors.current.text

  color: "transparent"
  state: (root.active) ? "ACTIVE" : "PASSIVE"

  states: [
    State {
      name: "ACTIVE"

      PropertyChanges {
        bgToggle.color: root.activeColor
        bgToggle.opacity: 1
        bgToggle.visible: true
        bgToggle.width: bgToggle.parent.width
        matIcon.color: root.activeIconColor
        matIcon.fill: 1
      }
    },
    State {
      name: "PASSIVE"

      PropertyChanges {
        bgToggle.color: root.passiveColor
        bgToggle.opacity: 0
        bgToggle.visible: false
        bgToggle.width: 0
        matIcon.color: root.passiveIconColor
        matIcon.fill: 0
      }
    }
  ]
  transitions: [
    Transition {
      from: "PASSIVE"
      to: "ACTIVE"

      SequentialAnimation {
        PropertyAction {
          property: "visible"
          target: bgToggle
        }

        ParallelAnimation {
          NumberAnimation {
            duration: Easings.standardTime
            easing.bezierCurve: Easings.standard
            properties: "width, opacity"
            target: bgToggle
          }

          ColorAnimation {
            duration: Easings.standardTime
            targets: [bgToggle, matIcon]
          }
        }
      }
    },
    Transition {
      from: "ACTIVE"
      to: "PASSIVE"

      SequentialAnimation {
        ParallelAnimation {
          NumberAnimation {
            duration: Easings.standardTime
            easing.bezierCurve: Easings.standard
            properties: "width, opacity"
            target: bgToggle
          }

          ColorAnimation {
            duration: Easings.standardTime
            targets: [bgToggle, matIcon]
          }
        }

        PropertyAction {
          property: "visible"
          target: bgToggle
        }
      }
    }
  ]

  Rectangle {
    id: bgToggle

    anchors.centerIn: parent
    height: this.width
    radius: this.width
  }

  MatIcon {
    id: matIcon

    anchors.centerIn: parent
    icon: ""
  }

  MouseArea {
    id: mouseArea
    layerColor: matIcon.color
  }
}
