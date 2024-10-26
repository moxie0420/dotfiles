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

    catppuccin = {
      enable = false;
      accent = "pink";
      flavor = "mocha";
    };
    systemd = {
      enable = true;
      enableXdgAutostart = true;
    };
    settings = {
      monitor = [
        "DP-1,3840x2160@98,0x0,1,vrr,2,bitdepth,10"
        "HDMI-A-1,1920x1080@60,auto-up,auto"
        "eDP-1,1920x1080@165.009995,0x0,1"
      ];
      cursor = {
        default_monitor = "DP-1";
        allow_dumb_copy = true;
      };
      misc = {
        vfr = false;
        force_default_wallpaper = 2;
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
      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };
      general = {
        gaps_in = 9;
        gaps_out = 12;
        border_size = 2;

        layout = "dwindle";

        allow_tearing = false;
        resize_on_border = true;
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

        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_offset = "0 15";
        shadow_range = 100;
        shadow_render_power = 2;
        shadow_scale = 0.97;
      };
      animations = {
        enabled = true;
        animation = [
          "border, 1, 2, default"
          "fade, 1, 4, default"
          "windows, 1, 3, default, popin 80%"
          "workspaces, 1, 2, default, slide"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      xwayland.force_zero_scaling = true;

      exec = [
      ];
      exec-once = [
        "${pkgs.openrgb-with-all-plugins}/bin/openrgb -p /home/moxie/.config/OpenRGB/default.orp"
        "gpg-agent --daemon"
        "[silent] vesktop"
        "[silent] spotify"
      ];

      "$mod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";

      windowrule = [
        "workspace 8, classs:(com.obsproject.Studio)"
      ];
      windowrulev2 = [
        "workspace 2, class:(code-url-handler)"
        "workspace 3 silent, class:(steam)"
        "workspace 3 silent, class:(lutris)"
        "workspace 9 silent, class:(vesktop)"
        "workspace 10 silent, title:(Spotify)"

        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"

        "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
        "idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$"
        "idleinhibit fullscreen, class:^(zen)$"
      ];
      workspace = [
        "8, monitor:HDMI-A-1"
        "9, monitor:HDMI-A-1"
        "10, monitor:HDMI-A-1"
      ];
      bindel = [
        ",XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
        ",XF86MonBrightnessUp,exec,brightnessctl set 5%+ "
        ",XF86MonBrightnessDown,exec,brightnessctl set 5%- "
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
      "$terminal" = "${pkgs.kitty}/bin/kitty -1";
      bind =
        [
          "$mod, Return, exec, $terminal"
          "$shiftMod, Q, killactive, 	i"
          "$mod, Space,  togglefloating,"
          "$mod, D,      exec, wofi --show drun -I -W 576 -H 270"

          "$mod, L, exec, loginctl lock-session"

          "$mod, F, fullscreen"
          "$shiftMod, F, fullscreenstate"

          "$mod, left,  movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, 	  movefocus, u"
          "$mod, down,  movefocus, d"

          "$shiftMod, Left,  moveactive, left,  visible"
          "$shiftMod, Right, moveactive, right, visible"
          "$shiftMod, Up,    moveactive, up,    visible"
          "$shiftMod, Down,  moveactive, down,  visible"

          "$mod,Plus,togglespecialworkspace, SPECIAL"

          "$mod, Print, exec, grim -g \"$(${pkgs.slurp}/bin/slurp)\" -t png -o $(xdg-user-dir PICTURES)/$(date +'%s_grim.png')"
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
    };
  };
}
