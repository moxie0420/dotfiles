{config, pkgs, lib, ... }:
{
	programs.wireshark = {
		enable = true;
		package = pkgs.wireshark;
	};
}
