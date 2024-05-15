{ pkgs, ... }:
{
	imports = [
		./desktop
		./polkit.nix
		./style.nix
		./hardware
 	];
	programs.adb.enable = true;
	users.users.moxie = {
		isNormalUser = true;
		extraGroups = [ 
			"wheel"
			"audio"
			"video"
			"pipewire"
			"plugdev"
			"wireshark"
			"adbusers"
			"vboxusers"
		];
    shell = pkgs.nushellFull;
	};

  time.timeZone = "America/Chicago";

  programs.direnv.enable = true;

  nix = {
    settings = {
      allowed-users = [
        "@wheel"
      ];
      trusted-users = [
	      "@wheel"
      ];
      substituters = [
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "01:00";
    };
  };
}
