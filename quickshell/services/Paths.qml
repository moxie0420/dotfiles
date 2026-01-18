pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  readonly property string home: Quickshell.env("HOME")
  readonly property string pictures: Quickshell.env("XDG_PICTURES_DIR") || `${home}/Pictures`
  readonly property string videos: Quickshell.env("XDG_VIDEOS_DIR") || `${home}/Videos`

  readonly property string data: `${Quickshell.env("XDG_DATA_HOME") || `${home}/.local/share`}/pineish`
  readonly property string state: `${Quickshell.env("XDG_STATE_HOME") || `${home}/.local/state`}/pineish`
  readonly property string cache: `${Quickshell.env("XDG_CACHE_HOME") || `${home}/.cache`}/pineish`
  readonly property string config: `${Quickshell.env("XDG_CONFIG_HOME") || `${home}/.config`}/pineish`

  function getPath(caller, url: string): string {
    const filename = url.split('/').pop();
    const filepath = root.cache + "/" + filename;
    const script = root.urlToPath(Qt.resolvedUrl("../scripts/cacheImg.sh"));

    const process = cacheImg.incubateObject(root, {
      "command": ["bash", script, url, root.urlToPath(root.cache)],
      "running": true
    });

    process.onStatusChanged = (status) => {
      if (status != Component.Ready)
        return;

      process.object.exited.connect((eCode, eStat) => {
        if (eCode == 0) {
          caller.source = filepath;
        } else {
          console.log("[ERROR] cacheImg exited with error code: " + eCode);
        }
        process.object.destroy();
      });
    }

    return ""
  }

  function urlToPath(url: url): string {
    return url.toString().replace("file://", "");
  }

  Component {
    id: cacheImg
    Process {}
  }
}
