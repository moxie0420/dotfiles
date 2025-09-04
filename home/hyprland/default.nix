{hostName, ...}: let
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

    settings = {
      "$terminal" = "uwsm app -- wezterm";
      "$fileManager" = "uwsm app -- nautilus --new-window";
      "$browser" = "uwsm app -- zen-twighlight";
      "$music" = "$terminal rmpc";
      "$webapp" = "$browser --app";

      monitor = [
        "HDMI-A-1,1920x1080@75,auto,1,vrr,2"
        "HDMI-A-2,1920x1080@60,auto-up,1"
        "eDP-1,1920x1080@165.009995,auto,1"
      ];

      exec-once = [
        "hyprsunset"
        "systemctl --user start hyprpolkitagent"
        "wl-clip-persist --clipboard regular & clipse -listen"
      ];

      exec = [
        "pkill -SIGUSR2 waybar || waybar"
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
    };
  };
}
