{ config, lib, pkgs, ... }:

{
	networking = {
		hostName = "nixUwU";
		enableIPv6 = false;
		useDHCP = lib.mkDefault true;
		dhcpcd.extraConfig = "noarp";
		firewall = {

		};
		hosts = {
			"127.0.0.1" = [ "nixUwU.localdomain" "nixUwU" ];
		};
	};
}
