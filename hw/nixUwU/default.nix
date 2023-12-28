{ config, pkgs, ... }:
{
    imports = [
        ./boot.nix
        ./disks.nix
        ./hardware.nix
        ./network.nix
        ../../common
	./rgb.nix
    ];
    environment.sessionVariables = {
	LIBVA_DRIVER_NAME = "nvidia";
	GBM_BACKEND = "nvidia-drm";
	__GLX_VENDOR_LIBRARY_NAME = "nvidia";
	VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
    };
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
