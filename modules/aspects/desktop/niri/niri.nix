{
  desktop,
  inputs,
  ...
}: {
  desktop.niri = {
    homeManager = {
      lib,
      pkgs,
      ...
    }: {
      home.packages = builtins.attrValues {
        inherit (pkgs) xwayland-satellite;
      };

      programs.niri.settings = {
        binds = let
          genNumAttrs = count: name: val: let
            inherit (builtins) genList listToAttrs;
          in
            listToAttrs (
              genList (i: {
                name = name i;
                value = val i;
              })
              count
            );
        in
          lib.mkMerge [
            {
              "Alt+Print".action.screenshot-window = [];
              "Ctrl+Print".action.screenshot-screen = [];
              "Mod+C".action.center-column = [];
              "Mod+Comma".action.consume-window-into-column = [];
              "Mod+Equal".action.set-column-width = ["+10%"];
              "Mod+F".action.maximize-column = [];
              "Mod+Minus".action.set-column-width = ["-10%"];
              "Mod+Period".action.expel-window-from-column = [];
              "Mod+R".action.switch-preset-column-width = [];
              "Mod+Shift+E".action.quit = [];
              "Mod+Shift+Equal".action.set-window-height = ["+10%"];
              "Mod+Shift+F".action.fullscreen-window = [];
              "Mod+Shift+Minus".action.set-window-height = ["-10%"];
              "Mod+Shift+P".action.power-off-monitors = [];
              "Mod+Shift+Slash".action.show-hotkey-overlay = [];
              "Mod+W".action.close-window = [];
              "Mod+WheelScrollDown" = {
                action.focus-workspace = "down";
                cooldown-ms = 150;
              };
              "Mod+WheelScrollLeft".action.focus-workspace = "left";
              "Mod+WheelScrollRight".action.focus-workspace = "right";
              "Mod+WheelScrollUp" = {
                action.focus-workspace = "up";
                cooldown-ms = 150;
              };
              "Print".action.screenshot = [];
              "XF86AudioLowerVolume".action.spawn = [
                "wpctl"
                "set-volume"
                "@DEFAULT_AUDIO_SINK@"
                "5%-"
              ];
              "XF86AudioMicMute".action.spawn = [
                "wpctl"
                "set-mute"
                "@DEFAULT_AUDIO_SOURCE@"
                "toggle"
              ];
              "XF86AudioMute".action.spawn = [
                "wpctl"
                "set-mute"
                "@DEFAULT_AUDIO_SINK@"
                "toggle"
              ];
              "XF86AudioRaiseVolume".action.spawn = [
                "wpctl"
                "set-volume"
                "@DEFAULT_AUDIO_SINK@"
                "5%+"
              ];
              "XF86MonBrightnessDown".action.spawn = [
                "brightnessctl"
                "set"
                "1%-"
              ];
              "XF86MonBrightnessUp".action.spawn = [
                "brightnessctl"
                "set"
                "1%+"
              ];
            }
            (genNumAttrs 10 (i: "Mod+${toString i}") (i: {
              action.focus-workspace = i;
            }))
            (genNumAttrs 10 (i: "Mod+Shift+${toString i}") (i: {
              action.move-column-to-workspace = i;
            }))

            {
              "Mod+Ctrl+H".action.move-column-left = [];
              "Mod+Ctrl+I".action.move-column-to-workspace-up = [];
              "Mod+Ctrl+J".action.move-window-down = [];
              "Mod+Ctrl+K".action.move-window-up = [];
              "Mod+Ctrl+L".action.move-column-right = [];
              "Mod+Ctrl+U".action.move-column-to-workspace-down = [];
              "Mod+H".action.focus-column-left = [];
              "Mod+I".action.focus-workspace-up = [];
              "Mod+J".action.focus-window-down = [];
              "Mod+K".action.focus-window-up = [];
              "Mod+L".action.focus-column-right = [];
              "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [];
              "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [];
              "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [];
              "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [];
              "Mod+Shift+H".action.focus-monitor-left = [];
              "Mod+Shift+I".action.move-workspace-up = [];
              "Mod+Shift+J".action.focus-monitor-down = [];
              "Mod+Shift+K".action.focus-monitor-up = [];
              "Mod+Shift+L".action.focus-monitor-right = [];
              "Mod+Shift+U".action.move-workspace-down = [];
              "Mod+U".action.focus-workspace-down = [];
            }

            {
              "Mod+Ctrl+Down".action.move-window-down = [];
              "Mod+Ctrl+End".action.move-column-to-last = [];
              "Mod+Ctrl+Home".action.move-column-to-first = [];
              "Mod+Ctrl+Left".action.move-column-left = [];
              "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [];
              "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [];
              "Mod+Ctrl+Right".action.move-column-right = [];
              "Mod+Ctrl+Up".action.move-window-up = [];
              "Mod+Down".action.focus-window-down = [];
              "Mod+End".action.focus-column-last = [];
              "Mod+Home".action.focus-column-first = [];
              "Mod+Left".action.focus-column-left = [];
              "Mod+Page_Down".action.focus-workspace-down = [];
              "Mod+Page_up".action.focus-workspace-up = [];
              "Mod+Right".action.focus-column-right = [];
              "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [];
              "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [];
              "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [];
              "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [];
              "Mod+Shift+Down".action.focus-monitor-down = [];
              "Mod+Shift+Left".action.focus-monitor-left = [];
              "Mod+Shift+Page_Down".action.move-workspace-down = [];
              "Mod+Shift+Page_Up".action.move-workspace-up = [];
              "Mod+Shift+Right".action.focus-monitor-right = [];
              "Mod+Shift+Up".action.focus-monitor-up = [];
              "Mod+Up".action.focus-window-up = [];
            }
          ];
        cursor = {
          hide-after-inactive-ms = 5000;
        };
        debug = {
          emulate-zero-presentation-time = {};
        };
        input = {
          focus-follows-mouse.enable = true;
          power-key-handling.enable = false;
        };
        layout = {
          always-center-single-column = true;
          center-focused-column = "on-overflow";
          default-column-width = {
            proportion = 0.5;
          };
          gaps = 8;
          preset-column-widths = [
            {proportion = 0.33333;}
            {proportion = 0.5;}
            {proportion = 0.66667;}
          ];
          preset-window-heights = [
            {proportion = 0.33333;}
            {proportion = 0.5;}
            {proportion = 0.66667;}
          ];
        };
        outputs = {
          HDMI-A-3.position = {
            x = 0;
            y = -1080;
          };

          HDMI-A-4 = {
            focus-at-startup = true;
            position = {
              x = 0;
              y = 0;
            };
          };
        };
        prefer-no-csd = true;
        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      };
    };
    # module dpendencies
    includes = [
      desktop.audio
      desktop.dconf
      desktop.keyring
      desktop.launcher
      desktop.notifications
      desktop.polkit
      desktop.wayland
      desktop.xdg

      # include window rules
      desktop.niri.windowRules
    ];
    nixos = {pkgs, ...}: {
      imports = with inputs; [
        niri.nixosModules.niri
      ];

      environment.pathsToLink = [
        "/share/xdg-desktop-portal"
        "/share/applications"
      ];

      environment.systemPackages = [
        pkgs.xwayland-satellite
      ];

      niri-flake.cache.enable = false;
      # Enable Niri
      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
    };
    provides.to-users.includes = [desktop.niri];
  };
  flake-file.inputs.niri = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:sodiboo/niri-flake";
  };
}
