{ inputs, ... }:
{
  imports = [
      ./boot.nix
      ./disks.nix
      ./hardware.nix
      ./network.nix
      ../../common
  ];
  environment.sessionVariables = {
		#__NV_PRIME_RENDER_OFFLOAD="1";
		#__NV_PRIME_RENDER_OFFLOAD_PROVIDER="NVIDIA-G0";
		LIBVA_DRIVER_NAME = "nvidia";
		XDG_SESSION_TYPE = "wayland";
		GBM_BACKEND = "nvidia-drm";
		#__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		WLR_NO_HARDWARE_CURSORS = "1";
		__VK_LAYER_NV_optimus="NVIDIA_only";
    WLR_DRM_DEVICES = "/dev/dri/card0";
    WLR_RENDERER = "vulkan";
  };

	nix.settings = {
    # add binary caches
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
  };

  nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay ];


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
