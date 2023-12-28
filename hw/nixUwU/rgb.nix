{ pkgs, config, ... }:
{
	services.hardware.openrgb = {
		enable = true;
		motherboard = "intel";
		package = pkgs.openrgb-with-all-plugins;
	};
}
