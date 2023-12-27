{ config, pkgs, ... }:
{
	programs = {
		steam = {
			enable = true;
			remotePlay.openFirewall = true;
		};
		gamescope = {
			enable = true;
			capSysNice = true;
		};
		gamemode.enable = true;
	};
    environment.systemPackages = with pkgs; [
		winePackages.waylandFull
		winetricks
		protontricks
		protonup-qt
    ];
    hardware.steam-hardware.enable = true;
}
