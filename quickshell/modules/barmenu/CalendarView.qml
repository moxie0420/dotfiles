pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.services

Item {
  property int index: SwipeView.index

  RowLayout {
    anchors.fill: parent
    anchors.margins: 10
    anchors.rightMargin: 5

    ColumnLayout {
      // Month display
      Layout.fillHeight: true
      Layout.minimumWidth: 30
      spacing: 0

      Rectangle {
        Layout.fillWidth: true
        bottomLeftRadius: 0
        bottomRightRadius: 0
        color: Colors.current.pine
        // Day display
        implicitHeight: 18
        radius: 20

        Text {
          id: weekDayText

          anchors.centerIn: parent
          color: Colors.current.text
          font.pointSize: 8
          text: Qt.formatDateTime(Time?.date, "ddd")
        }
      }

      Rectangle {
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: Colors.current.pine
        radius: 10
        topLeftRadius: 0
        topRightRadius: 0

        Text {
          anchors.centerIn: parent
          color: Colors.current.text
          rotation: -90
          text: Qt.formatDateTime(Time?.date, "MMMM")
        }
      }
    }

    MonthGrid {
      id: monthGrid

      property int currDay: parseInt(Qt.formatDateTime(Time?.date, "d"))
      property int currMonth: parseInt(Qt.formatDateTime(Time?.date, "M")) - 1

      Layout.fillHeight: true
      Layout.fillWidth: true
      spacing: 0

      delegate: Item {
        required property var model

        Rectangle {
          anchors.centerIn: parent
          color: (model.day === monthGrid.currDay && monthGrid.currMonth == model.month) ? Colors.current.pine : "transparent"
          height: parent.height
          radius: 6
          width: this.height
        }

        Text {
          anchors.centerIn: parent
          color: (parent.model.month == monthGrid.currMonth) ? (parent.model.day == monthGrid.currDay) ? Colors.current.text : Colors.current.text : Colors.withAlpha(Colors.current.text, 0.70)
          font.pointSize: 10
          text: parent.model.day
        }
      }
    }
  }

}
