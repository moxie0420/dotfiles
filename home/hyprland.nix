{ pkgs, ... }:
{
	services.mako = {
    enable = true;
		anchor = "bottom-right";
		borderRadius = 20;
		textColor = "#cdd6f4";
		defaultTimeout = 3000;
  };
	programs = {
    wofi.enable = true;
		eww = {
    	enable = true;
    	configDir = ./eww;
			package = pkgs.eww-wayland;
  	};
		swaylock = {
			enable = true;
			package = pkgs.swaylock-effects;
		};
    	waybar = {
			enable = true;
			systemd = {
				enable = true;
				target = "hyprland-session.target";
			};
			settings = [
				{
					layer = "top";
					output = [ "DP-1"];
					modules-left = [ "hyprland/workspaces" ];
					modules-center = [ "hyprland/window" ];
					modules-right = [ "memory" "disk" "cpu" "temperature" "clock" "tray" ];
					"hyprland/workspaces" = { format = "{name}"; };
					"hyprland/window" = {
						format = " {title} ";
    					max-length = 50;
    					rewrite = {
								"(.*) — Mozilla Firefox" = "🌎 $1";
			      		"vim (.*)" = " $1";
								"sudo vim (.*)" = " $1";
    					};
					};
					"memory" = { format = "RAM: {percentage}%";	};
					"disk" = { format = "{percentage_free}% remaining on /";};
					"cpu" = { format = "CPU: {usage}%"; };
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
					output = [ "eDP-1" ];
					modules-left = [ "hyprland/workspaces" ];
					modules-center = [ "hyprland/window" ];
					modules-right = [ "wireplumber" "memory" "cpu" "temperature" "backlight" "battery" "clock" "tray" ];
					"hyprland/workspaces" = { format = "{name}"; };
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
					"memory" = { format = "RAM: {percentage}%";	};
					"disk" = { format = "{percentage_free}% remaining on /";};
					"cpu" = { format = "CPU: {usage}%"; };
					"backlight" = {
						format = "{percent}% {icon}";
						format-icons = ["" ""];
					};
					"battery" = {
						format = "{capacity}%";
						states = {
							warning = 35;
							critical  = 20;
						};
					};
					"tray" = {
						icon-size = 21;
						show-passive-items = true;
						spacing = 8;
					};
				}
				{
					layer = "top";
					output = ["HDMI-A-2"];
					modules-left = [ "hyprland/workspaces" ];
					modules-center = [ "hyprland/window" ];
					modules-right = [ "memory" "cpu" "temperature" "clock" "tray" ];
					"hyprland/workspaces" = { format = "{name}"; };
					"hyprland/window" = {
						format = "{title}";
    					max-length = 50;
    					rewrite = {
							"(.*) — Mozilla Firefox" = "🌎 $1";
			      			"vim (.*)" = " $1";
							"sudo vim (.*)" = " $1";
    					};
					};
					"memory" = { format = "RAM: {percentage}%";	};
					"disk" = { format = "{percentage_free}% remaining on /";};
					"cpu" = { format = "CPU: {usage}%"; };
					"tray" = {
						icon-size = 21;
						show-passive-items = true;
						spacing = 5;
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

	wayland.windowManager.hyprland = {
		enable = true;
		systemd.enable = true;
		settings = {
			env = [
				#"WLR_DRM_DEVICES,/dev/dri/card1"
				"XCURSOR_SIZE,24"
			];
			monitor = [
				"DP-1,3840x2160@144,0x0,1,bitdepth,10"
				"HDMI-A-2,1360x768@60,-1360x0,1,bitdepth,10"
				"eDP-1,1920x1080@165.009995,0x0,1,bitdepth,10"
				",preferred,auto,1,mirror,eDP-1"
			];
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
				border_size = 1;

				layout = "dwindle";
			};
			decoration = {
				rounding = 10;
				drop_shadow = true;
				#blur_new_optimizations = true;
			};
			dwindle = {
				pseudotile = true;
				preserve_split = true;
			};
			exec = [
				"pkill hyprpaper; hyprpaper"
				"pkill eww; eww daemon"
			];
			exec-once = [
				"hyprctl setcursor Catppuccin-Mocha-Pink-Cursors 24"
				"gpg-agent --daemon"
				"[silent] vesktop"
				"[silent] spotify"
			];

			"$mod" = "SUPER";
			"$shiftMod" = "SUPER_SHIFT";

			bindm = [
				"$mod, mouse:272, movewindow"
				"$mod, mouse:273, resizewindow"
			];
			windowrule = [
				"workspace 8, classs:(com.obsproject.Studio)"
			];
			windowrulev2 = [
				"workspace 2, class:(code-url-handler)"
				"workspace 3 silent, class:(steam)"
				"workspace 3 silent, class:(lutris)"
				"workspace 9 silent, class:(discord)"
				"workspace 9 silent, class:(vesktop)"
				"workspace 10 silent, title:(Spotify)"
			];
			workspace = [
				"1,monitor:DP-1"
				"2,monitor:DP-1"
				"3,monitor:DP-1"
				"4,monitor:DP-1"
				"5,monitor:DP-1"
				"6,monitor:DP-1"
				"7,monitor:DP-1"
				"8,monitor:DP-1"
				"9,monitor:HDMI-A-2, gapsout:10"
				"10,monitor:HDMI-A-2, gapsout:10"
			];
			bind = [
				"$mod, Return, exec, kitty -1"
				"$shiftMod, Q, killactive, 	i"
				"$mod, Space,  togglefloating,"
				"$mod, D,      exec, wofi --show drun -I"

				"$mod, L, exec, loginctl lock-session"

				"$mod, F,      fullscreen"
				"$shiftMod, F, fakefullscreen"

				"$mod, left,  movefocus, l"
				"$mod, right, movefocus, r"
				"$mod, up, 	  movefocus, u"
				"$mod, down,  movefocus, d"

				"$mod, Print, exec, grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | wl-copy "

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
			] ++ (
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
         	])
        10)
      );
		};
	};
}
