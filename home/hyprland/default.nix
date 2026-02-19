{
  hostName,
  lib,
  ...
}: let
  mainMonitor =
    if hostName == "nixOwO"
    then "eDP-1"
    else "HDMI-A-1";
in {
  imports = [
    ./bindings.nix
    ./envs.nix
    ./input.nix
    ./theme.nix
    ./windows.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    settings = lib.mkMerge [
      {
        monitor = [
          "HDMI-A-1, 1920x1080@75,     0x0,     1"
          "HDMI-A-2, preferred,     0x-1080, 1"
          "eDP-1,    1920x1080@165, 0x0,     1"
        ];

        render.direct_scanout = 2;

        exec-once = [
          "awww-daemon"
          "wl-clip-persist --clipboard regular & clipse -listen"
        ];

        workspace =
          [
            "8,  monitor:HDMI-A-2"
            "9,  monitor:HDMI-A-2"
            "10, monitor:HDMI-A-2"
          ]
          ++ (
            # workspaces monitor binds 1-7
            # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            builtins.concatLists (builtins.genList (
                x: [
                  "${toString (x + 1)}, monitor:${mainMonitor}"
                ]
              )
              10)
          );
      }
    ];
  };
}
