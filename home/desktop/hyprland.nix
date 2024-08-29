{pkgs, ...}: {
  imports = [
    ./waybar.nix
  ];

  services = {
    mako = {
      enable = true;
      anchor = "bottom-right";
      defaultTimeout = 3000;
    };
    copyq = {
      enable = true;
      systemdTarget = "hyprland-session.target";
    };
  };

  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 420;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 32;
      gtk_dark = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    catppuccin = {
      enable = true;
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
      };
      general = {
        gaps_in = 9;
        gaps_out = 12;
        border_size = 2;

        layout = "dwindle";

        allow_tearing = false;
      };
      decoration = {
        rounding = 15;
        drop_shadow = true;
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
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
        "float, class:(clipse)"
        "size 622 652, class:(clipse)"
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
