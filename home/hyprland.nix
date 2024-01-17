{ config, pkgs, lib, ... }:
{
    programs = {
        wofi.enable = true;
        swaylock = {
			enable = true;
			package = pkgs.swaylock-effects;
		};
        waybar = {
			enable = true;
			settings = [{
				modules-left = [ "hyprland/workspaces" ];
				modules-center = [ "hyprland/window" ];
				modules-right = [ "wireplumber" "memory" "disk" "cpu" "temperature" "backlight" "battery" "clock" "tray" ];

				"hyprland/workspaces" = {
					format = "{name}";
				};

				"hyprland/window" = {
					format = "{title}";
    					max-length = 50;
    					rewrite = {
							"(.*) — Mozilla Firefox" = "🌎 $1";
					        "vim (.*)" = " $1";
							"sudo vim (.*)" = " $1";
    					};
				};

				"wireplumber" = {
					format-muted = "muted";
					on-click = "pavucontrol";
				};

				"memory" = {
					format = "RAM: {percentage}%";	
				};

				"disk" = {
					format = "{percentage_free}% remaining on /";
				};

				"cpu" = {
					format = "CPU: {usage}%";
				};

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
			}];
		};
    };

    wayland.windowManager.hyprland = {
		enable = true;
		systemd.enable = true;
		settings = {
			env = [
				"WLR_DRM_DEVICES,/dev/dri/card0"
				"XCURSOR_SIZE,24"
			];
			monitor = [
				"eDP-1,1920x1080@165.009995,0x0,1"
				",preferred,auto,1,mirror,eDP-1"
			];
			input = {
				kb_layout = "us";
				follow_mouse = "1";
				touchpad = {
					natural_scroll = "no";
				};
				sensitivity = "0";
			};
			general = {
				gaps_in = "5";
				gaps_out = "7";
				border_size = "1";

				layout = "dwindle";
			};
			decoration = {
				rounding = 10;

				drop_shadow = "yes";
			};
			dwindle = {
				pseudotile = "yes";
				preserve_split = "yes";
			};
			exec = [
				"pkill waybar; waybar &"
			];
			exec-once = [
				"hyprpaper"
			];
			"$mod" = "SUPER";
			"$shiftMod" = "SUPER_SHIFT";
			bindm = [
				"$mod, mouse:272, movewindow"
				"$mod, mouse:273, resizewindow"
			];
			bind = [
				"$mod, Return, exec, 		kitty"
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
            		])
          	    10)
            );
		};
	};
}