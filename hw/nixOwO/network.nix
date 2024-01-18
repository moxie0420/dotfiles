{ config, pkgs, ... }:

{
	systemd.services.NetworkManager-wait-online.enable = false;
	networking = {
		hostName = "nixOwO";
		enableIPv6 = true;
		wireless = {
			iwd.enable = true;
		};
		firewall = {

		};
	};
	services.globalprotect = {
		enable = true;
		settings = {
			
		};
	};
}
