{pkgs, ...}: let
  terminal = command: "uwsm app -- nix${pkgs.wezterm}/bin/wezterm ${command}";
in {
  wayland.windowManager.hyprland.settings = {
    bind =
      [
        "SUPER, Y, exec, $webapp=https://youtube.com/"

        "SUPER, return, exec, $terminal"
        "SUPER, F, exec, $fileManager"
        "SUPER, B, exec, $browser"
        "SUPER, M, exec, $music"
        "SUPER, N, exec, $terminal -e hx"
        "SUPER, T, exec, $terminal -e btop"
        "SUPER, D, exec, $terminal -e lazydocker"

        "SUPER, space, exec, rofi -matching glob -show drun -show-icons -run-command 'uwsm app -- {cmd}'"

        "SUPER, W, killactive,"
        "SUPER, Backspace, killactive,"

        # End active session
        "SUPER, ESCAPE, exec, loginctl lock-session"
        "SUPER SHIFT, ESCAPE, exit,"
        "SUPER CTRL, ESCAPE, exec, reboot"
        "SUPER SHIFT CTRL, ESCAPE, exec, poweroff"

        # Control tiling
        "SUPER, J, togglesplit, # dwindle"
        "SUPER, P, pseudo, # dwindle"
        "SUPER, V, togglefloating,"
        "SUPER SHIFT, Plus, fullscreen,"

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

        # Resize active window
        "SUPER, minus, resizeactive, -100 0"
        "SUPER, equal, resizeactive, 100 0"
        "SUPER SHIFT, minus, resizeactive, 0 -100"
        "SUPER SHIFT, equal, resizeactive, 0 100"

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

        # Clipse
        "CTRL SUPER, V, exec, ${terminal "--class clipse -e clipse"}"

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
      ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    bindl = [
      # Requires playerctl
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
