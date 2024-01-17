{ config, pkgs, ... }:

{
	environment.variables = {
		NIXOS_OZONE_WL = "1";
      	__GL_GSYNC_ALLOWED = "0";
      	__GL_VRR_ALLOWED = "0";
      	_JAVA_AWT_WM_NONEREPARENTING = "1";
      	SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      	DISABLE_QT5_COMPAT = "0";
      	GDK_BACKEND = "wayland,x11";
      	ANKI_WAYLAND = "1";
      	DIRENV_LOG_FORMAT = "";
      	QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      	QT_QPA_PLATFORM = "wayland";
      	QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      	MOZ_ENABLE_WAYLAND = "1";
      	WLR_BACKEND = "vulkan";
      	WLR_RENDERER = "vulkan";
      	XDG_SESSION_TYPE = "wayland";
      	SDL_VIDEODRIVER = "wayland";
      	XDG_CACHE_HOME = "/home/moxie/.cache";
      	CLUTTER_BACKEND = "wayland";
		SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK = "1";
	};
	services ={
		hardware.openrgb = {
			enable = true;
			motherboard = "amd";
			package = pkgs.openrgb-with-all-plugins;
		};
		xserver = {
			enable = true;
			displayManager.gdm = {
				enable = true;
			};
			videoDrivers = [ "amdgpu" "nvidia" ];
		};	
	};
	programs = {
		hyprland = {
			enable = true;
			xwayland.enable = true;
		};
	};
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-gtk
		];
	};
}
