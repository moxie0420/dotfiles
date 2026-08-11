{
  desktop.niri.binds = {
    homeManager = {
      wayland.windowManager.niri.settings = {
        binds = {
          "Alt+Print"    .screenshot-window = {};
          "Ctrl+Alt+Delete"  .quit = {};
          "Ctrl+Print"   .screenshot-screen = {};
          "Mod+1" .focus-workspace = 1;
          "Mod+2" .focus-workspace = 2;
          "Mod+3" .focus-workspace = 3;
          "Mod+4" .focus-workspace = 4;
          "Mod+5" .focus-workspace = 5;
          "Mod+6" .focus-workspace = 6;
          "Mod+7" .focus-workspace = 7;
          "Mod+8" .focus-workspace = 8;
          "Mod+9" .focus-workspace = 9;
          "Mod+BracketLeft"  .consume-or-expel-window-left = {};
          "Mod+BracketRight" .consume-or-expel-window-right = {};
          "Mod+C"  .center-column = {};
          "Mod+Comma"   .consume-window-into-column = {};
          "Mod+Ctrl+1".move-column-to-workspace = 1;
          "Mod+Ctrl+2".move-column-to-workspace = 2;
          "Mod+Ctrl+3".move-column-to-workspace = 3;
          "Mod+Ctrl+4".move-column-to-workspace = 4;
          "Mod+Ctrl+5".move-column-to-workspace = 5;
          "Mod+Ctrl+6".move-column-to-workspace = 6;
          "Mod+Ctrl+7".move-column-to-workspace = 7;
          "Mod+Ctrl+8".move-column-to-workspace = 8;
          "Mod+Ctrl+9".move-column-to-workspace = 9;
          "Mod+Ctrl+C"  .center-visible-columns = {};
          "Mod+Ctrl+Down"   .move-window-down = {};
          "Mod+Ctrl+End"    .move-column-to-last = {};
          "Mod+Ctrl+F"  .expand-column-to-available-width = {};
          "Mod+Ctrl+H"      .move-column-left = {};
          "Mod+Ctrl+Home"   .move-column-to-first = {};
          "Mod+Ctrl+I"         .move-column-to-workspace-up = {};
          "Mod+Ctrl+J"      .move-window-down = {};
          "Mod+Ctrl+K"      .move-window-up = {};
          "Mod+Ctrl+L"      .move-column-right = {};
          "Mod+Ctrl+Left"   .move-column-left = {};
          "Mod+Ctrl+Page_Down" .move-column-to-workspace-down = {};
          "Mod+Ctrl+Page_Up"   .move-column-to-workspace-up = {};
          "Mod+Ctrl+R" .reset-window-height = {};
          "Mod+Ctrl+Right"  .move-column-right = {};
          "Mod+Ctrl+Shift+R"  .switch-preset-window-height = {};
          "Mod+Ctrl+Shift+WheelScrollDown"  .move-column-right = {};
          "Mod+Ctrl+Shift+WheelScrollUp"    .move-column-left = {};
          "Mod+Ctrl+U"         .move-column-to-workspace-down = {};
          "Mod+Ctrl+Up"     .move-window-up = {};

          "Mod+Ctrl+WheelScrollDown" = {
            _props.cooldown-ms = 150;
            move-column-to-workspace-down = {};
          };

          "Mod+Ctrl+WheelScrollLeft"  .move-column-left = {};
          "Mod+Ctrl+WheelScrollRight" .move-column-right = {};

          "Mod+Ctrl+WheelScrollUp" = {
            _props.cooldown-ms = 150;
            move-column-to-workspace-up = {};
          };

          "Mod+Down"        .focus-window-down = {};
          "Mod+End"         .focus-column-last = {};
          "Mod+Equal"  .set-column-width = "+10%";
          "Mod+F"        .maximize-column = {};
          "Mod+H"           .focus-column-left = {};
          "Mod+Home"        .focus-column-first = {};
          "Mod+I"              .focus-workspace-up = {};
          "Mod+J"           .focus-window-down = {};
          "Mod+K"           .focus-window-up = {};
          "Mod+L"           .focus-column-right = {};
          "Mod+Left"        .focus-column-left = {};
          "Mod+M"  .maximize-window-to-edges = {};
          "Mod+Minus"  .set-column-width = "-10%";

          "Mod+O" = {
            _props.repeat = false;
            toggle-overview = {};
          };

          "Mod+Page_Down"      .focus-workspace-down = {};
          "Mod+Page_Up"        .focus-workspace-up = {};
          "Mod+Period"  .expel-window-from-column = {};
          "Mod+R"  .switch-preset-column-width = {};

          "Mod+Return" = {
            _props.hotkey-overlay-title = "Open a Terminal: kitty";
            spawn = "kitty";
          };

          "Mod+Right"             .focus-column-right = {};
          "Mod+Shift+Ctrl+Down"   .move-column-to-monitor-down = {};
          "Mod+Shift+Ctrl+H"      .move-column-to-monitor-left = {};
          "Mod+Shift+Ctrl+J"      .move-column-to-monitor-down = {};
          "Mod+Shift+Ctrl+K"      .move-column-to-monitor-up = {};
          "Mod+Shift+Ctrl+L"      .move-column-to-monitor-right = {};
          "Mod+Shift+Ctrl+Left"   .move-column-to-monitor-left = {};
          "Mod+Shift+Ctrl+Right"  .move-column-to-monitor-right = {};
          "Mod+Shift+Ctrl+Up"     .move-column-to-monitor-up = {};
          "Mod+Shift+Down"        .focus-monitor-down = {};
          "Mod+Shift+E"      .quit = {};
          "Mod+Shift+Equal"  .set-window-height = "+10%";
          "Mod+Shift+F"  .fullscreen-window = {};
          "Mod+Shift+H"           .focus-monitor-left = {};
          "Mod+Shift+I"          .move-workspace-up = {};
          "Mod+Shift+J"           .focus-monitor-down = {};
          "Mod+Shift+K"           .focus-monitor-up = {};
          "Mod+Shift+L"           .focus-monitor-right = {};
          "Mod+Shift+Left"        .focus-monitor-left = {};
          "Mod+Shift+Minus"  .set-window-height = "-10%";
          "Mod+Shift+P"      .power-off-monitors = {};
          "Mod+Shift+Page_Down"  .move-workspace-down = {};
          "Mod+Shift+Page_Up"    .move-workspace-up = {};
          "Mod+Shift+R"   .switch-preset-column-width-back = {};
          "Mod+Shift+Right"       .focus-monitor-right = {};
          "Mod+Shift+Slash"       .show-hotkey-overlay = {};
          "Mod+Shift+U"          .move-workspace-down = {};
          "Mod+Shift+Up"          .focus-monitor-up = {};
          "Mod+Shift+V"  .switch-focus-between-floating-and-tiling = {};
          "Mod+Shift+WheelScrollDown"       .focus-column-right = {};
          "Mod+Shift+WheelScrollUp"         .focus-column-left = {};

          "Mod+Space" = {
            _props.hotkey-overlay-title = "Run an Application: fuzzel";
            spawn = "fuzzel";
          };

          "Mod+U".focus-workspace-down = {};
          "Mod+Up".focus-window-up = {};
          "Mod+V".toggle-window-floating = {};

          "Mod+W" = {
            _props.repeat = false;
            close-window = {};
          };

          # "Mod+Q".toggle-column-tabbed-display = {};

          "Mod+WheelScrollDown" = {
            _props.cooldown-ms = 150;
            focus-workspace-down = {};
          };

          "Mod+WheelScrollLeft".focus-column-left = {};
          "Mod+WheelScrollRight".focus-column-right = {};

          "Mod+WheelScrollUp" = {
            _props.cooldown-ms = 150;
            focus-workspace-up = {};
          };

          "Print".screenshot = {};

          "Super+Alt+L" = {
            _props.hotkey-overlay-title = "Lock the Screen: gtklock";
            spawn-sh = "gtklock -d";
          };

          XF86AudioLowerVolume = {
            _props.allow-when-locked = true;
            spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
          };

          XF86AudioMicMute = {
            _props.allow-when-locked = true;
            spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          };

          XF86AudioMute = {
            _props.allow-when-locked = true;
            spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };

          XF86AudioNext = {
            _props.allow-when-locked = true;
            spawn-sh = "playerctl next";
          };

          XF86AudioPlay = {
            _props.allow-when-locked = true;
            spawn-sh = "playerctl play-pause";
          };

          XF86AudioPrev = {
            _props.allow-when-locked = true;
            spawn-sh = "playerctl previous";
          };

          XF86AudioRaiseVolume = {
            _props.allow-when-locked = true;
            spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
          };

          XF86AudioStop = {
            _props.allow-when-locked = true;
            spawn-sh = "playerctl stop";
          };

          XF86MonBrightnessDown = {
            _props.allow-when-locked = true;
            spawn-sh = "brightnessctl --class=backlight set 10%-";
          };

          XF86MonBrightnessUp = {
            _props.allow-when-locked = true;
            spawn-sh = "brightnessctl --class=backlight set +10%";
          };
        };
      };
    };
  };
}
