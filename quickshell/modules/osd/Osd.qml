import QtQuick
import QtQuick.Layouts
import QtQuick.VectorImage
import Quickshell
import Quickshell.Services.Pipewire

import qs.services

Scope {
  PanelWindow {
    anchors.bottom: true
		exclusiveZone: 0

		margins.bottom: screen.height / 5

		implicitWidth: 400
		implicitHeight: 50
		color: "transparent"

    mask: Region {}

    // osd background
    Rectangle {
      anchors.fill: parent
	  	radius: height / 2
      color: Colors.withAlpha(Colors.current.base, 0.8)

      RowLayout {
        VectorImage {
					source: "../../Assets/audio-volume-high.svg"
				}

				Rectangle {
				  Layout.fillWidth: true
					implicitHeight: 10
					radius: 20
          color: Colors.current.text

          Rectangle {
            implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
						radius: parent.radius

            anchors {
						  left: parent.left
							top: parent.top
							bottom: parent.bottom
						}
          }
				}
      }
    }
  }
}

