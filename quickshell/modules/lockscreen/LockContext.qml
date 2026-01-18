import QtQuick
import Quickshell
import Quickshell.Services.Pam

Scope {
  id: root

  signal unlocked()
	signal failed()

  // shared between all lock surfaces
  property string currentText: ""
	property bool unlockInProgress: false
	property bool showFailure: false

	// Clear the failure text once the user starts typing.
	onCurrentTextChanged: showFailure = false;

  function tryUnlock() {
    if (currentText === "") return;

		root.unlockInProgress = true;
		pam.start();
  }

  PamContext {
    id: pam

    configDirectory: "pam"
		config: "password.conf"

    onPamMessage: {
			if (this.responseRequired) {
				this.respond(root.currentText);
			}
		}

    onCompleted: result => {
			if (result == PamResult.Success) {
				root.unlocked();
			} else {
				root.currentText = "";
				root.showFailure = true;
			}

			root.unlockInProgress = false;
		}
  }
}
