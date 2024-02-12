{ pkgs, ... }:
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
				"wireplumber" = {
					format-muted = "muted";
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
				"DP-1,3840x2160@144,0x0,1,bitdepth,10"
				"HDMI-A-2,1360x768@60,-1360x0,1,bitdepth,10"
				"eDP-1,1920x1080@165.009995,0x0,1,bitdepth,10"
				",preferred,auto,1,mirror,eDP-1"
			];
			input = {
				kb_layout = "us";
				follow_mouse = 1;
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
				"pkill waybar; waybar &"
				"pkill hyprpaper; hyprpaper"
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
