{ config, pkgs, ... }:

{
	systemd.services.NetworkManager-wait-online.enable = false;
	networking = {
		hostName = "nixOwO";
		enableIPv6 = false;
		networkmanager = {
			enable = true;
			wifi = {
				powersave = true;
				scanRandMacAddress = true;
				backend = "iwd";
			};
		};
		firewall = {

		};
	};
}
