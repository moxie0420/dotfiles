{ pkgs, ... }:
{
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
			enable = true;
			enableRenice = true;
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
