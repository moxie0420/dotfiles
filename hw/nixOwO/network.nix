{ config, pkgs, ... }:

{
	systemd.services.NetworkManager-wait-online.enable = false;
	networking = {
		hostName = "nixOwO";
		enableIPv6 = false;
		networkmanager = {
			enable = false;
			wifi = {
				powersave = true;
				scanRandMacAddress = true;
				backend = "iwd";
			};
		};
		wireless = {
			enable = false;
			iwd.enable = true;
		};
		firewall = {

		};
	};
}
