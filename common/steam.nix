{ pkgs, ... }:
{
	services.xserver.desktopManager.retroarch = {
		enable = true;
		package = pkgs.retroarch;
	};
	programs = {
		steam = {
			enable = true;
			remotePlay.openFirewall = true;
			gamescopeSession.enable = false;
		};
		gamescope = {
			enable = false;
			capSysNice = true;
		};
		gamemode = {
			enable = false;
			enableRenice = false;
		};
	};
  environment.systemPackages = with pkgs; [
		wineWowPackages.waylandFull
		winetricks
		protontricks
		protonup-qt
  ];
  hardware.steam-hardware.enable = true;
}
