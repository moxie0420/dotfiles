{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		(lutris.override {
			extraPkgs = pkgs: [
		        	wineWowPackages.staging
       			];
    		})
		discord
	];

	programs = {
		gamemode = {
			enable = true;
			enableRenice = true;
		};
		steam = {
			enable = true;
			remotePlay.openFirewall = true;
		};
		gamescope = {
			enable = true;
			capSysNice = true;
		};
	};
}
