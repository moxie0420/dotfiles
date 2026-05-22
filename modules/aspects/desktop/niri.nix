{
  inputs,
  desktop,
  ...
}: {
  flake-file.inputs = {
    awww.url = "git+https://codeberg.org/LGFae/awww";
    niri.url = "github:sodiboo/niri-flake";
  };

  desktop.niri = {
    # module dpendencies
    includes = [
      desktop.audio
      desktop.dconf
      desktop.launcher
      desktop.notifications
      desktop.polkit
      desktop.wayland
      desktop.xdg
    ];

    nixos = {pkgs, ...}: {
      imports = with inputs; [
        niri.nixosModules.niri
      ];

      environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];

      environment.systemPackages = [
        inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
        pkgs.xwayland-satellite
      ];

      # Enable Niri
      programs.niri.enable = true;

      # Use Niri unstable
      nixpkgs.overlays = [inputs.niri.overlays.niri];
      programs.niri.package = pkgs.niri-unstable;
    };

    homeManager = {
      lib,
      pkgs,
      ...
    }: let
      inherit (pkgs.stdenv.hostPlatform) system;
    in {
      home.packages = builtins.attrValues {
        inherit (pkgs) xwayland-satellite;
        inherit (inputs.awww.packages.${system}) awww;
      };

      programs.niri.settings = {
        binds = let
          genNumAttrs = count: name: val: let
            inherit (builtins) genList listToAttrs;
          in
            listToAttrs (genList (i: {
                name = name i;
                value = val i;
              })
              count);
        in
          lib.mkMerge [
            {
              "Mod+Shift+Slash".action.show-hotkey-overlay = [];

              "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"];
              "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
              "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
              "XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
              "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "1%+"];
              "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "1%-"];

              "Mod+W".action.close-window = [];

              "Mod+Comma".action.consume-window-into-column = [];
              "Mod+Period".action.expel-window-from-column = [];

              "Mod+R".action.switch-preset-column-width = [];
              "Mod+F".action.maximize-column = [];
              "Mod+Shift+F".action.fullscreen-window = [];
              "Mod+C".action.center-column = [];

              "Mod+Minus".action.set-column-width = ["-10%"];
              "Mod+Equal".action.set-column-width = ["+10%"];

              "Mod+Shift+Minus".action.set-window-height = ["-10%"];
              "Mod+Shift+Equal".action.set-window-height = ["+10%"];

              "Print".action.screenshot = [];
              "Ctrl+Print".action.screenshot-screen = [];
              "Alt+Print".action.screenshot-window = [];

              "Mod+Shift+E".action.quit = [];
              "Mod+Shift+P".action.power-off-monitors = [];

              "Mod+WheelScrollDown" = {
                cooldown-ms = 150;
                action.focus-workspace = "down";
              };

              "Mod+WheelScrollUp" = {
                cooldown-ms = 150;
                action.focus-workspace = "up";
              };

              "Mod+WheelScrollRight".action.focus-workspace = "right";
              "Mod+WheelScrollLeft".action.focus-workspace = "left";
            }
            (genNumAttrs 10 (i: "Mod+${toString i}") (i: {action.focus-workspace = i;}))
            (genNumAttrs 10 (i: "Mod+Shift+${toString i}") (i: {action.move-column-to-workspace = i;}))

            {
              "Mod+H".action.focus-column-left = [];
              "Mod+J".action.focus-window-down = [];
              "Mod+K".action.focus-window-up = [];
              "Mod+L".action.focus-column-right = [];

              "Mod+Ctrl+H".action.move-column-left = [];
              "Mod+Ctrl+J".action.move-window-down = [];
              "Mod+Ctrl+K".action.move-window-up = [];
              "Mod+Ctrl+L".action.move-column-right = [];

              "Mod+Shift+H".action.focus-monitor-left = [];
              "Mod+Shift+J".action.focus-monitor-down = [];
              "Mod+Shift+K".action.focus-monitor-up = [];
              "Mod+Shift+L".action.focus-monitor-right = [];

              "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [];
              "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [];
              "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [];
              "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [];

              "Mod+U".action.focus-workspace-down = [];
              "Mod+I".action.focus-workspace-up = [];

              "Mod+Ctrl+U".action.move-column-to-workspace-down = [];
              "Mod+Ctrl+I".action.move-column-to-workspace-up = [];

              "Mod+Shift+U".action.move-workspace-down = [];
              "Mod+Shift+I".action.move-workspace-up = [];
            }

            {
              "Mod+Left".action.focus-column-left = [];
              "Mod+Down".action.focus-window-down = [];
              "Mod+Up".action.focus-window-up = [];
              "Mod+Right".action.focus-column-right = [];

              "Mod+Ctrl+Left".action.move-column-left = [];
              "Mod+Ctrl+Down".action.move-window-down = [];
              "Mod+Ctrl+Up".action.move-window-up = [];
              "Mod+Ctrl+Right".action.move-column-right = [];

              "Mod+Home".action.focus-column-first = [];
              "Mod+End".action.focus-column-last = [];

              "Mod+Ctrl+Home".action.move-column-to-first = [];
              "Mod+Ctrl+End".action.move-column-to-last = [];

              "Mod+Shift+Left".action.focus-monitor-left = [];
              "Mod+Shift+Down".action.focus-monitor-down = [];
              "Mod+Shift+Up".action.focus-monitor-up = [];
              "Mod+Shift+Right".action.focus-monitor-right = [];

              "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [];
              "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [];
              "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [];
              "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [];

              "Mod+Page_Down".action.focus-workspace-down = [];
              "Mod+Page_up".action.focus-workspace-up = [];

              "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [];
              "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [];

              "Mod+Shift+Page_Down".action.move-workspace-down = [];
              "Mod+Shift+Page_Up".action.move-workspace-up = [];
            }
          ];

        cursor = {
          hide-after-inactive-ms = 5000;
        };

        debug = {
          emulate-zero-presentation-time = true;
        };

        input = {
          focus-follows-mouse.enable = true;
          power-key-handling.enable = false;
        };

        layout = {
          always-center-single-column = true;
          center-focused-column = "on-overflow";
          gaps = 8;

          preset-column-widths = [
            {proportion = 0.33333;}
            {proportion = 0.5;}
            {proportion = 0.66667;}
          ];

          default-column-width = {
            proportion = 0.5;
          };

          preset-window-heights = [
            {proportion = 0.33333;}
            {proportion = 0.5;}
            {proportion = 0.66667;}
          ];
        };

        prefer-no-csd = true;

        outputs = let
          aboveMonitor = monitor: {
            inherit (monitor.position) x;
            y = monitor.position.y - monitor.mode.height;
          };

          monitors = let
            fullHD = {
              width = 1920;
              height = 1080;
              refresh = 60.000;
            };

            origin = {
              x = 0;
              y = 0;
            };
          in {
            HDMI-A-1 = {
              focus-at-startup = true;
              mode =
                fullHD
                // {
                  refresh = 75.000;
                };
              position = origin;
            };

            HDMI-A-2 = {
              mode = fullHD;
              position = aboveMonitor monitors.HDMI-A-1;
            };
          };
        in
          monitors;

        screenshot-path = "~/pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        spawn-at-startup = [
          {argv = ["awww-daemon"];}
          {argv = ["wl-clip-persist" "--clipboard" "regular"];}
          {argv = ["clipse" "-listen"];}
        ];
      };
    };
  };
}
