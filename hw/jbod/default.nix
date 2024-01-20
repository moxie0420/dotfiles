{ config, pkgs, lib, ... }:
{
    imports = [
        ./disks.nix
    ];

    users.users.moxie = {
        isNormalUser = true;
        extraGroups = [ 
			"wheel"
			"audio"
			"video"
			"pipewire"
			"plugdev"
			"wireshark"
		];
        shell = pkgs.fish;
    };

    time.timeZone = "America/Chicago";

	programs.direnv.enable = true;

    nix = {
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
		};
		gc = {
			automatic = true;
  			dates = "01:00";
		};
	};
}