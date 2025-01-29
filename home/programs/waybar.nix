{pkgs, ...}: {
  programs = {
    waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = [
        {
          layer = "top";
          output = ["DP-1" "HDMI-A-1"];
          modules-left = ["hyprland/workspaces"];
          modules-center = ["hyprland/window"];
          modules-right = ["memory" "disk" "cpu" "temperature" "clock" "tray" "custom/notifications"];
          "hyprland/workspaces" = {format = "{name}";};
          "hyprland/window" = {
            seperate-outputs = true;
            format = " {title} ";
            max-length = 50;
            rewrite = {
              "(.*) — Mozilla Firefox" = "🌎 $1";
              "vim (.*)" = " $1";
              "sudo vim (.*)" = " $1";
            };
          };
          "memory" = {format = "RAM: {percentage}%";};
          "disk" = {format = "{percentage_free}% remaining on /";};
          "cpu" = {format = "CPU: {usage}%";};
          "backlight" = {
            format = "{percent}% {icon}";
            format-icons = ["" ""];
          };
          "battery" = {
            format = "{capacity}%";
            format-icons = ["" "" "" "" ""];
          };
          "tray" = {
            icon-size = 21;
            show-passive-items = true;
            spacing = 5;
          };
          "custom/notifications" = {
            on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t";
            format = "";
          };
        }
        {
          layer = "top";
          output = ["HDMI-A-2"];
          modules-left = ["hyprland/workspaces"];
          modules-center = ["hyprland/window"];
          modules-right = ["memory" "disk" "cpu" "temperature" "clock" "tray"];
          "hyprland/workspaces" = {format = "{name}";};
          "hyprland/window" = {
            seperate-outputs = true;
            format = " {title} ";
            max-length = 50;
            rewrite = {
              "(.*) — Mozilla Firefox" = "🌎 $1";
              "vim (.*)" = " $1";
              "sudo vim (.*)" = " $1";
            };
          };
          "memory" = {format = "RAM: {percentage}%";};
          "disk" = {format = "{percentage_free}% remaining on /";};
          "cpu" = {format = "CPU: {usage}%";};
          "backlight" = {
            format = "{percent}% {icon}";
            format-icons = ["" ""];
          };
          "battery" = {
            format = "{capacity}%";
            format-icons = ["" "" "" "" ""];
          };
          "tray" = {
            icon-size = 21;
            show-passive-items = true;
            spacing = 5;
          };
        }

        {
          layer = "top";
          output = ["eDP-1"];
          modules-left = ["hyprland/workspaces"];
          modules-center = ["hyprland/window"];
          modules-right = [
            "wireplumber"
            "memory"
            "cpu"
            "temperature"
            "backlight"
            "battery"
            "clock"
            "tray"
          ];
          "hyprland/workspaces" = {format = "{name}";};
          "hyprland/window" = {
            format = " {title} ";
            max-length = 50;
            rewrite = {
              "(.*) — Mozilla Firefox" = "🌎 $1";
              "vim (.*)" = " $1";
              "sudo vim (.*)" = " $1";
            };
          };
          "wireplumber" = {
            format = "{icon} {volume}%";
            format-icons = ["" "" ""];
            format-muted = "";
            on-click = "pwvucontrol";
          };
          "memory" = {format = " {percentage}%";};
          "disk" = {format = "{percentage_free}% remaining on /";};
          "cpu" = {format = " {usage}%";};
          "backlight" = {
            format = "{icon} {percent}%";
            format-icons = ["󰹐" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
          };
          "battery" = {
            format = "{icon} {capacity}%";
            format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            format-Charging = "󰂄 Charging";

            tooltip-format-Discharging = ''
              {capacity}% Charged
              {timeTo} left until empty

              Using {power} watts
            '';

            tooltip-format-Charging = ''
              {capacity}% Charged
              {timeTo} left until full

              Using {power} watts
            '';

            states = {
              warning = 35;
              critical = 20;
            };
          };
          "tray" = {
            icon-size = 21;
            show-passive-items = true;
            spacing = 8;
          };
        }
      ];
      style = builtins.readFile ../files/waybar.css;
    };
  };
}
