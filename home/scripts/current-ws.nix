{pkgs, ...}: let
  current-ws = pkgs.writeScriptBin "current-ws.sh" ''
    #!/usr/bin/env bash
    hyprctl monitors -j | ${pkgs.jq}/bin/jq '.[] | select(.focused) | .activeWorkspace.id'

    ${pkgs.socat}/bin/socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
      stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}'
  '';
in {
  home.packages = [current-ws];
}
