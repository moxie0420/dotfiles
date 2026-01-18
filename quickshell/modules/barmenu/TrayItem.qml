pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray

Item {
  id: root

  required property int index
  property var menu: TrayItemMenu {
    height: root.stackView.height
    trayMenu: trayMenu
    width: root.stackView.width
  }
  required property SystemTrayItem modelData
  required property var stackView

  implicitHeight: trayItemIcon.width
  implicitWidth: this.implicitHeight

  Image {
    id: trayItemIcon

    anchors.centerIn: parent
    antialiasing: true
    height: this.width
    width: 18
    mipmap: true
    smooth: true

    source: {
      const icon = root.modelData?.icon;
      if(icon.includes("?path=")) {
        const [name, path] = icon.split("?path=");
        return `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
      }
      return root.modelData.icon;
    }

    MouseArea {
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      anchors.fill: parent

      onClicked: mevent => {
        if (mevent.button == Qt.LeftButton) {
          root.modelData.activate();
          return;
        }

        if (root.stackView.depth > 1) {
          if (root.stackView.currentItem == root.menu) {
            // unwind nesting
            if (root.menu.trayMenu != trayMenu) {
              root.menu.trayMenu = trayMenu;
              return;
            }
            root.stackView.pop();
          } else {
            root.stackView.replace(root.menu, StackView.ReplaceTransition);
          }
        } else {
          root.stackView.push(root.menu);
        }
      }
    }
  }

  QsMenuOpener {
    id: trayMenu
    menu: root.modelData?.menu
  }
}
