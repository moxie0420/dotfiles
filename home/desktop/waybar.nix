{pkgs, ...}: {
  programs = {
    waybar = {
      enable = true;
      package = pkgs.waybar;
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };
      settings = [
        {
          layer = "top";
          output = ["DP-1" "HDMI-A-1"];
          modules-left = ["hyprland/workspaces"];
          modules-center = ["hyprland/window"];
          modules-right = ["memory" "disk" "cpu" "temperature" "clock" "tray"];
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
            /*
            "wireplumber"
            */
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
            format = "volume: {volume}%";
            format-muted = "Muted";
            on-click = "pavucontrol";
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
      style = ''
        * {
        				border:        none;
        				border-radius: 0;
        				font-size:     17px;
        				font-weight:     bold;
        				box-shadow:    none;
        				text-shadow:   none;
        				transition-duration: 0s;
        }
        window#waybar {
        	margin-top: 4px;
        				background: transparent;
        }
        #workspaces {
        	padding: 5px;
        				border-radius: 20px;
        				background: rgba(30, 30, 46, 0.8);
        				transition: none;
        }
        #workspaces button {
        				transition: none;
        				color:      rgba(205, 214, 244, 0.8);
        				background: transparent;
        }
        #workspaces button.active {
        	border:        none;
        	border-radius: 20px;
        	color:  	#181825;
        	background: #f5c2e7;
        }
        #workspaces button:hover {
        				border: 3px solid #cba6f7;
        	border-radius: 20px;
        				transition: none;
        				box-shadow: inherit;
        				text-shadow: inherit;
        				color: #cba6f7;
        }
        #workspaces button.urgent {
        				color:      rgba(180, 190, 254, 1);
        }

        #window {
        	border-radius: 20px;
        	background: rgba(30, 30, 46, 0.85);
        }

        #tray {
        	margin-left: 4px;
        				margin-right: 4px;
        	border-radius: 20px;
        	padding-left: 10px;
        				padding-right: 10px;
        	background: rgba(30, 30, 46, 0.85);
        }

        #clock {
        	margin-left: 4px;
        				margin-right: 4px;
        	border-radius: 20px;
        	padding-left: 10px;
        				padding-right: 10px;
        	background: rgba(30, 30, 46, 0.85);
        	color: #89b4fa;
        }

        #temperature {
        	margin-left: 4px;
        				margin-right: 4px;
        	border-radius: 20px;
        	padding-left: 10px;
        				padding-right: 10px;
        	background: rgba(30, 30, 46, 0.85);
        	color: #89dceb;
        }
        #temperature.critical {
        	color: #f38ba8;
        }

        #battery {
        	margin-left: 4px;
        				margin-right: 4px;
        	border-radius: 20px;
        	padding-left: 10px;
        				padding-right: 10px;
        	background: rgba(30, 30, 46, 0.85);
        	color: #a6e3a1;
        }
        #battery.warning {
        	color: #f9e2af;
        }
        #battery.critical {
        	color: #f38ba8;
        }

        #backlight {
        	margin-left: 4px;
        				margin-right: 4px;
        	border-radius: 20px;
        	padding-left: 10px;
        				padding-right: 10px;
        	background: rgba(30, 30, 46, 0.85);
        	color: #f5e0dc;
        }

        #cpu {
        	margin-left: 4px;
        				margin-right: 4px;
        	border-radius: 20px;
        	padding-left: 10px;
        				padding-right: 10px;
        	background: rgba(30, 30, 46, 0.85);
        	color: #cba6f7;
        }

        #disk {
        	margin-left: 4px;
        				margin-right: 4px;
        	border-radius: 20px;
        	padding-left: 10px;
        				padding-right: 10px;
        	background: rgba(30, 30, 46, 0.85);
        	color: #f5c2e7;
        }

        #memory {
        	margin-left: 4px;
        				margin-right: 4px;
        	border-radius: 20px;
        	padding-left: 10px;
        				padding-right: 10px;
        	background: rgba(30, 30, 46, 0.85);
        	color: #f2cdcd;
        }

        #wireplumber {
        	margin-left: 4px;
        				margin-right: 4px;
        	border-radius: 20px;
        	padding-left: 10px;
        				padding-right: 10px;
        	background: rgba(30, 30, 46, 0.85);
        	color: #eba0ac;
        }
      '';
    };
  };
}
