{pkgs, ...}: {
  imports = [
    ./waybar.nix
  ];

  services.mako = {
    enable = true;
    anchor = "bottom-right";
    borderRadius = 15;
    textColor = "#cdd6f4";
    defaultTimeout = 3000;
  };
  programs = {
    wofi = {
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
    swaylock = {
      enable = false;
      package = pkgs.swaylock-effects;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      env = [
        "WLR_NO_HARDWARE_CURSORS,0"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "XCURSOR_THEME,rose-pine"
        "XCURSOR_SIZE,24"
      ];
      monitor = [
        "DP-1,3840x2160@98,0x0,1,vrr,2,bitdepth,10"
        "HDMI-A-1,1920x1080@60,auto-up,auto"
        "eDP-1,1920x1080@165.009995,0x0,1"
        #",preferred,auto,1,mirror,eDP-1"
      ];
      cursor = {
        default_monitor = "DP-1";
      };
      misc = {
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
        "${pkgs.clipse}/bin/clipse -listen"
        "gpg-agent --daemon"
        "[silent] vesktop"
        "[silent] spotify"
      ];

      "$mod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";

      bindm = [
        "$mod, mouse:272, movewindow"
        "$shiftMod, mouse:272, resizewindow"
      ];
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
      bind =
        [
          "$mod, Return, exec, kitty -1"
          "$shiftMod, Q, killactive, 	i"
          "$mod, Space,  togglefloating,"
          "$mod, D,      exec, wofi --show drun -I -W 576 -H 270"

          "$mod, L, exec, loginctl lock-session"

          "$mod, F,      fullscreen"
          "$shiftMod, F, fakefullscreen"

          "$mod, left,  movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, 	  movefocus, u"
          "$mod, down,  movefocus, d"

          "$mod, P, exec, ${pkgs.kitty}/bin/kitty --class clipse -e ${pkgs.clipse}/bin/clipse"

          "$mod, Print, exec, grim -g \"$(${pkgs.slurp}/bin/slurp)\" -t png -o $(xdg-user-dir PICTURES)/$(date +'%s_grim.png')"

          "$shiftMod, Left,  movewindow, left,  visible"
          "$shiftMod, Right, movewindow, right, visible"
          "$shiftMod, Up,    movewindow, up,    visible"
          "$shiftMod, Down,  movewindow, down,  visible"

          ",XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume 53 5%+"
          ",XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume 53 5%-"
          ",XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute 53 toggle"
          ",XF86AudioMicMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute 54 toggle"
          ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          ",XF86AudioStop, exec, ${pkgs.playerctl}/bin/playerctl stop"
          ",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
          ",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
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