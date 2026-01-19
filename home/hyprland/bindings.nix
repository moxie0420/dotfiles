{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = let
    terminal = "${pkgs.wezterm}/bin/wezterm";
    fileManager = "${pkgs.nautilus}/bin/nautilus --new-window";
    webapp = "zen-twilight --kiosk";
  in {
    bind =
      [
        "SUPER, Y, exec, ${webapp} https://youtube.com/"

        "SUPER, return, exec, ${terminal}"
        "SUPER, F, exec, ${fileManager}"
        "SUPER, M, exec, ${terminal} -e rmpc"
        "SUPER, N, exec, ${terminal} -e hx"
        "SUPER, T, exec, ${terminal} -e btop"

        "SUPER, space, exec, rofi -matching glob -show drun -show-icons"

        "SUPER, W, killactive,"
        "SUPER, Backspace, killactive,"

        # End active session
        ", F13, exec, loginctl lock-session"
        ", XF86PowerOff, exec, poweroff"

        # Control tiling
        "SUPER, J, togglesplit, # dwindle"
        "SUPER, P, pseudo, # dwindle"
        "SUPER, V, togglefloating,"
        "SUPER SHIFT, F, fullscreen,"

        # Move focus with mainMod + arrow keys
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        # Swap active window with the one next to it with mainMod + SHIFT + arrow keys
        "SUPER SHIFT, left, swapwindow, l"
        "SUPER SHIFT, right, swapwindow, r"
        "SUPER SHIFT, up, swapwindow, u"
        "SUPER SHIFT, down, swapwindow, d"

        # Scroll through existing workspaces with mainMod + scroll
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"

        # Super workspace floating layer
        "SUPER, S, togglespecialworkspace, magic"
        "SUPER SHIFT, S, movetoworkspace, special:magic"

        # Screenshots
        ", PRINT, exec, hyprshot -m region"
        "SHIFT, PRINT, exec, hyprshot -m window"
        "CTRL, PRINT, exec, hyprshot -m output"

        # Color picker
        "SUPER, PRINT, exec, hyprpicker -a"

        "SUPER, comma, workspace, -1"
        "SUPER, period, workspace, +1"
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
              "SUPER, ${ws}, workspace, ${toString (x + 1)}"
              "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    bindel = [
      # Laptop multimedia keys for volume and LCD brightness
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl set 1%+"
      ",XF86MonBrightnessDown, exec, brightnessctl set 1%-"
    ];

    bindl = [
      # Requires playerctl
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioStop, exec, playerctl stop"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
