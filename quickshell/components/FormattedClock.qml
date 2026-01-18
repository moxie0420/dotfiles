import QtQuick
import qs.services

Text {
  anchors.centerIn: parent
  color: Colors.current.text
  font.pointSize: 11
  text: Qt.formatDateTime(Time.date, "h:mm:ss")
}

