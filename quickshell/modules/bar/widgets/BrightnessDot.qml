import QtQuick

import qs.components
import qs.services

Item {
  Text {
    anchors.centerIn: parent
    color: Colors.current.foam
    font.pointSize: 12
    text: "󰃠"
  }

  MouseArea {
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    layerColor: Colors.current.foam

    onClicked: mevent => {
      switch (mevent.button) {
      case Qt.RightButton:
        Brightness.increase();
        break;
      case Qt.LeftButton:
        Brightness.decrease();
        break;
      }
    }
    onWheel: event => {
      if (event.angleDelta.y > 0) {
        Brightness.increase();
      } else {
        Brightness.decrease();
      }
    }
  }
}
