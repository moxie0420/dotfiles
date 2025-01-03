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
        "DP-1,3840x2160@120,auto,1,vrr,2"
        "HDMI-A-2,1920x1080@60,auto-up,1"
        "eDP-1,1920x1080@165.009995,auto,1"
      ];
      cursor = {
        default_monitor = "DP-1";
        no_hardware_cursors = 0;
        use_cpu_buffer = true;
      };

      decoration = {
        rounding = 16;

        blur = {
          enabled = true;
          brightness = 0.75;
          contrast = 1.0;
          noise = 0.01;

          vibrancy = 0.2;
          vibrancy_darkness = 0.5;

          passes = 4;
          size = 3;

          popups = true;
          popups_ignorealpha = 0.2;
        };

        shadow = {
          range = 100;
          render_power = 2;

          offset = "0 15";
          scale = 0.97;
        };
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

      misc = {
        vrr = 2;
      };

      xwayland.force_zero_scaling = true;

      exec = [
        "pkill waybar; uwsm app -- waybar"
        "swaync-client --reload-config"
      ];

      exec-once = [
        "systemctl start --user hyprpaper"
        "uwsm app -- GDK_BACKEND=wayland swaync"
        "uwsm app -- ${pkgs.openrgb-with-all-plugins}/bin/openrgb -p /home/moxie/.config/OpenRGB/default.orp"
        "gpg-agent --daemon"
      ];

      "$mod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";
      "$terminal" = "${pkgs.kitty}/bin/kitty -1";

      windowrulev2 = [
        "workspace 3 silent, class:(steam)"
        "workspace 3 silent, class:(lutris)"
        "workspace 8 silent, class:(com.obsproject.Studio)"
        "workspace 9 silent, class:(vesktop)"
        "workspace 10 silent, title:(Spotify)"

        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"

        "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
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
                "${toString (x + 1)}, monitor:DP-1"
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
          "$mod, D,      exec, uwsm app -- wofi"

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
