{ ... }:
{
  imports = [
      ./boot.nix
      ./disks.nix
      ./hardware.nix
      ./network.nix
      ../../common
  ];
  environment.sessionVariables = {
		#LIBVA_DRIVER_NAME = "nvidia";
		#GBM_BACKEND = "nvidia-drm";
		#__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		#VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json";
		#WLR_NO_HARDWARE_CURSORS = "1";
  };
  systemd.services = {
		"nv-power-limit" = {
			enable = false;
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
