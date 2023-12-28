{ config, pkgs, ... }:
{
    imports = [
        ./boot.nix
        ./disks.nix
        ./hardware.nix
        ./network.nix
        ../../common
    ];
    systemd.services = {
	"nv-power-limit" = {
		enable = true;
		description = "set nvidia gpu power to max";
		script = ''
			/run/current-system/sw/bin/nvidia-smi -pm ENABLED
			/run/current-system/sw/bin/nvidia-smi -pl 269
  		'';
		wantedBy = [ "multi-user.target" ];
	};
    };
    system.stateVersion = "23.05";
}
