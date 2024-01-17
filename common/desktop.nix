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
		hardware.openrgb = {
			enable = true;
			motherboard = "amd";
			package = pkgs.openrgb-with-all-plugins;
		};
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
		QT_QPA_PLATFORM = "wayland;xcb";
		ANKI_WAYLAND = "1";
		NIXOS_OZONE_WL = "1";
      	__GL_GSYNC_ALLOWED = "0";
      	__GL_VRR_ALLOWED = "0";
      	_JAVA_AWT_WM_NONEREPARENTING = "1";
      	DISABLE_QT5_COMPAT = "0";
      	GDK_BACKEND = "wayland,x11";
      	DIRENV_LOG_FORMAT = "";
      	QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      	QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      	MOZ_ENABLE_WAYLAND = "1";
      	WLR_BACKEND = "vulkan";
      	WLR_RENDERER = "vulkan";
      	XDG_SESSION_TYPE = "wayland";
      	SDL_VIDEODRIVER = "wayland";
      	CLUTTER_BACKEND = "wayland";
	};
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
		   xdg-desktop-portal-gtk 
		];
	};
}
