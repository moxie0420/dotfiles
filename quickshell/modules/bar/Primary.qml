import QtQuick
import QtQuick.Layouts

import qs.modules.barmenu
import qs.services

Rectangle {
  id: root

  required property string actWinName
  required property string barState


  color: Colors.withAlpha(Colors.current.surface, 0.9)
  radius: 20

  RowLayout {
    anchors.fill: parent
    spacing: 0

    BarMenu {
      Layout.fillHeight: true
      Layout.fillWidth: true

      actWinName: root.actWinName
      barState: root.barState
    }
  }
}
