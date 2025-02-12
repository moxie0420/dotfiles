{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.hyprpicker
  ];
  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.default;
    settings = {
      monitor = [
        "HDMI-A-1,1920x1080@75,auto,1"
        "HDMI-A-2,1920x1080@60,auto-up,1"
        "eDP-1,1920x1080@165.009995,auto,1"
      ];
      cursor = {
        no_hardware_cursors = 0;
        use_cpu_buffer = true;
      };

      decoration = {
        rounding = 16;
      };

      general = {
        gaps_in = 9;
        gaps_out = 12;
        border_size = 2;

        layout = "dwindle";

        allow_tearing = false;
        resize_on_border = true;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        mouse_refocus = false;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = "0";
      };

      exec = [
        "pkill waybar; uwsm app -- waybar"
        "swaync-client --reload-config"
      ];

      exec-once = [
        "uwsm app -- GDK_BACKEND=wayland swaync"
        "${pkgs.openrgb-with-all-plugins}/bin/openrgb -p /home/moxie/.config/OpenRGB/default.orp"
      ];

      "$mod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";
      "$terminal" = "${pkgs.kitty}/bin/kitty -1";

      windowrulev2 = [
        "fullscreen, class:steam_app_\\d+$"
        "workspace 4, class:steam_app_\\d+$"
        "idleinhibit focus, class:steam_app_\\d+$"

        "workspace 3, class:steam title:Steam"

        "workspace 8 silent, class:(com.obsproject.Studio)"
        "workspace 9, class:(vesktop)"
        "workspace 10 silent, class:(Spotify)"

        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"

        "idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$"
        "idleinhibit fullscreen, class:^(zen)$"
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
                "${toString (x + 1)}, monitor:HDMI-A-1"
                "${toString (x + 1)}, monitor:eDP-1"
              ]
            )
            10)
        );

      bind =
        [
          "$shiftMod, Q, killactive, 	i"
          "$mod, Space,  togglefloating,"

          "$mod, Return, exec, uwsm app -- $terminal"
          "$mod, D,      exec, rofi -matching glob -show drun -show-icons -run-command 'uwsm app -- {cmd}'"

          "$mod, L, exec, loginctl lock-session"

          "$mod, F, fullscreen"
          "$shiftMod, F, fullscreenstate"

          "$mod, left,  movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, 	  movefocus, u"
          "$mod, down,  movefocus, d"

          "$shiftMod, Left,  movewindow, left,  visible"
          "$shiftMod, Right, movewindow, right, visible"
          "$shiftMod, Up,    movewindow, up,    visible"
          "$shiftMod, Down,  movewindow, down,  visible"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );

      bindel = [
        ",XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindl = [
        ",XF86MonBrightnessUp,exec,${pkgs.brillo}/bin/brillo -A 5"
        ",XF86MonBrightnessDown,exec,${pkgs.brillo}/bin/brillo -U 5"
        ",switch:Lid Switch, exec, systemctl suspend"
        ",XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ",XF86AudioStop, exec, ${pkgs.playerctl}/bin/playerctl stop"
        ",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$shiftMod, mouse:272, resizewindow"
      ];
    };
  };
}
