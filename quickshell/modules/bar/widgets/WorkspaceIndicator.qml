import QtQuick
import QtQuick.Layouts
import qs.services

Rectangle {
  id: root

  required property BarState barstate

  clip: true
  height: 22
  implicitWidth: workRow.width + 8
  radius: 20

  color: Colors.withAlpha(
    Colors.current.surface,
    (
      barstate.actWinName === "Desktop" &&
      barstate.barState != "FULLY_EXPANDED"
    ) ? 0.50 : 0.75
  )

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Easings.standardDecelTime
      easing.bezierCurve: Easings.standardDecel
    }
  }

  RowLayout {
    id: workRow

    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.top: parent.top

    spacing: 5

    Rectangle {
      implicitHeight: 20
      implicitWidth: 20
      radius: 20


      color: Colors.withAlpha(
        Colors.current.pine,
        (
          root.barstate.actWinName === "Desktop" &&
          root.barstate.barState != "FULLY_EXPANDED"
        ) ? 0.50 : 0.75
      )

      TextMetrics {
        id: activeWindowText
        font.pointSize: 11
        elide: Qt.ElideRight
        elideWidth: 400
        text: root.barstate.actWinName
      }

      Text {
        anchors.centerIn: parent
        color: Colors.current.text
        text: Hypr.monitorFor(root.barstate.modelData)?.activeWorkspace?.id ?? "0"
      }
    }

    Text {
      elide: Text.ElideRight
      color: Colors.current.text
      text: activeWindowText.elidedText
    }
  }
}
