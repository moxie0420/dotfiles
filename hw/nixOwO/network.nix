{ ... }:

{
	systemd.services.NetworkManager-wait-online.enable = false;
	networking = {
		hostName = "nixOwO";
		enableIPv6 = true;
		wireless.iwd = {
			enable = true;
			settings = {
				general = {
						EnableNetworkConfiguration = false;
				};
			};
		};
		firewall = {

		};
	};
}
