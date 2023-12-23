{ config, pkgs, ... }:
{
    includes = [
		./audio.nix
		./desktop.nix
		./steam.nix
    ];

    time.timeZone = "America/Chicago";

	programs.direnv.enable = true;

    nix = {
		settings = {
			substituters = ["https://hyprland.cachix.org"];
    		trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];

			experimental-features = [ "nix-command" "flakes" ];
		};
		gc = {
			automatic = true;
  			dates = "01:00";
		};
	};
}