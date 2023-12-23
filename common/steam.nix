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
		wineWowPackages.stable
		wine
		(wine.override { wineBuild = "wine64"; })
		(wineWowPackages.full.override {
			wineRelease = "staging";
			mingwSupport = true;
		})
		wineWowPackages.staging
		wineWowPackages.waylandFull
		winetricks
		protontricks
		protonup-qt
    ];
    hardware.steam-hardware.enable = true;
}