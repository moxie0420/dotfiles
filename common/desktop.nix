{ config, pkgs, inputs, ... }:
{
	environment.systemPackages = with pkgs; [
		gnome.file-roller
		ns-usbloader
		flameshot
		(pkgs.discord.override {
			withOpenASAR = true;
			withVencord = true;
		})
		catppuccin-cursors
		glfw-wayland
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
		xserver = {
			enable = true;
			displayManager.gdm = {
				enable = true;
				wayland = true;
				autoSuspend = false;
			};
		};
		dbus = {
			enable = true;
			packages = with pkgs; [dconf];
		};
	};
	programs = {
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
	environment.sessionVariables = {
		NIXOS_OZONE_WL = "0";
		GDK_BACKEND = "wayland";
		QT_QPA_PLATFORM = "wayland;xcb";
		CLUTTER_BACKEND = "wayland";
		SDL_VIDEODRIVER = "wayland";
		ANKI_WAYLAND = "1";
	};
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
		   xdg-desktop-portal-gtk 
		];
	};
}
