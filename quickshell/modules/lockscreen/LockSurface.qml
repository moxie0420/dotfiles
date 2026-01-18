import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell.Wayland

import qs.services

Rectangle {
  id: root

  required property LockContext context
	readonly property ColorGroup colors: Window.active ? Colors.current.pine : Colors.current.muted

	color: Colors.current.base

  Button {
		text: "Its not working, let me out"
		onClicked: root.context.unlocked();
	}

	Background {}

	Label {
	  id: clock

    anchors {
			horizontalCenter: parent.horizontalCenter
			top: parent.top
			topMargin: 100
		}

	  renderType: Text.NativeRendering
		font.pointSize: 80

    text: Qt.formatDateTime(Time.date, "h:mm")
	}

  // Password Box
	ColumnLayout {
	  visible: Window.active

	  anchors {
			horizontalCenter: parent.horizontalCenter
			top: parent.verticalCenter
		}

	  RowLayout {
	    TextField {
	      id: passwordBox

	      implicitWidth: 400
				padding: 10

				focus: true
				enabled: !root.context.unlockInProgress
				echoMode: TextInput.Password
				inputMethodHints: Qt.ImhSensitiveData

        onTextChanged: root.context.currentText = this.text;
        onAccepted: root.context.tryUnlock();

        Connections {
          target: root.context

          function onCurrentTextChanged() {
						passwordBox.text = root.context.currentText;
					}
        }

        background: Rectangle {
          radius: 20

        }
	    }

	    Button {
	      text: "Unlock"
				padding: 10

				// don't steal focus from the text box
				focusPolicy: Qt.NoFocus

				enabled: !root.context.unlockInProgress && root.context.currentText !== "";
				onClicked: root.context.tryUnlock();
	    }
	  }

    Label {
			visible: root.context.showFailure
			color: Colors.current.text
			text: "Incorrect password"
		}
	}
}
