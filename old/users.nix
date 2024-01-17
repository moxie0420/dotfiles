{ config, pkgs, lib, ...}:
{
	editorconfig = {
		enable = false;
		settings = {
			"*" = {
				end_of_line = "lf";
				insert_final_newline = "true";
			};
		};
	};
	home = {
		stateVersion = "23.05";
		username = "moxie";
		homeDirectory = "/home/moxie";
		packages = with pkgs; [
			neofetch
			pavucontrol
			spotify
			vulkan-tools
			fritzing
			qbittorrent
			yubikey-manager
		];
	};
}
