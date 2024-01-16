{ config, pkgs, ... }:
{
	programs = {
		steam = {
			enable = true;
			remotePlay.openFirewall = true;
			gamescopeSession.enable = true;
		};
		gamescope = {
			enable = true;
			capSysNice = true;
		};
		gamemode.enable = true;
	};
    environment.systemPackages = with pkgs; [
		wineWowPackages.waylandFull
		winetricks
		protontricks
		protonup-qt
    ];
    hardware.steam-hardware.enable = true;
}
