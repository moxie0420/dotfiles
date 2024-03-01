{ pkgs, inputs, lib, config, ... }:
{
	environment.systemPackages = with pkgs; [
		grim
		slurp
		wl-clipboard
		(pkgs.catppuccin-gtk.override
			{
				accents = [ "pink" ];
				variant = "mocha";
			}
		)
	];
	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		noto-fonts-extra
		nerdfonts
	];
	services = {
		gvfs.enable = true;
		tumbler.enable = true;
		flatpak.enable = true;
		udisks2.enable = true;
		hardware.openrgb = {
			enable = true;
			motherboard = if config.networking.hostName == "nixOwO" then "amd" else "intel";
			package = pkgs.openrgb-with-all-plugins;
		};
		dbus = {
			enable = true;
			packages = with pkgs; [dconf];
		};
	};
	programs = {
		regreet = {
			enable = true;
			cageArgs = [ "-s" "-m" "last" ];
			settings = {
				background = {
					path = "/etc/nixos/wallpapers/lain.jpg";
				};
				GTK = {
					application_prefer_dark_theme = true;
					cursor_theme_name = "Catppuccin-Mocha-Pink-Cursors";
					font_name = "ComicShannsMono";
					theme_name = "Catppuccin-Mocha-Standard-Pink-Dark";
					icon_theme_name = "Catppuccin-Mocha-Standard-Pink-Dark";
				};
				commands = {
					reboot = [ "systemctl" "reboot" ];
					poweroff = [ "systemctl" "poweroff"  ];
				};
			};
		};
		hyprland = {
			enable = true;
			xwayland.enable = true;
			package = inputs.hyprland.packages.${pkgs.system}.hyprland;
		};
		thunar = {
			enable = true;
			plugins = with pkgs.xfce; [
				thunar-archive-plugin
				thunar-volman
				thunar-media-tags-plugin
			];
		};
		neovim = {
			enable = true;
			vimAlias = true;
			viAlias = true;
		};
		dconf.enable = true;
		gnome-disks.enable = true;
		fish.enable = true;
		file-roller.enable = true;
	};
	environment = {
		sessionVariables = {
			QT_QPA_PLATFORM = "wayland;xcb";
			ANKI_WAYLAND = "1";
			NIXOS_OZONE_WL = "1";
			_JAVA_AWT_WM_NONEREPARENTING = "1";
			DISABLE_QT5_COMPAT = "0";
			GDK_BACKEND = "wayland,x11";
			DIRENV_LOG_FORMAT = "";
			QT_AUTO_SCREEN_SCALE_FACTOR = "1";
			QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
			MOZ_ENABLE_WAYLAND = "1";
			XDG_SESSION_TYPE = "wayland";
			SDL_VIDEODRIVER = "wayland";
			CLUTTER_BACKEND = "wayland";
		};
	};
}
