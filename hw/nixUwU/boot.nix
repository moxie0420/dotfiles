{ config, pkgs, ... }:
{ 
    boot = {
		loader = {
			timeout = 0;
			systemd-boot = {
				enable = true;
				editor = false;
				configurationLimit = 10;
			};
			grub = {
				enable = false;
				device = "nodev";
				efiSupport = true;
				useOSProber = true;
			};
			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot";
			};
		};
		initrd = {
			availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "uas" "sd_mod" ];
  			kernelModules = [ ];
			compressor = "lz4";
			systemd.enable = true;
		};
  		kernelModules = [ "kvm-intel" "v4l2loopback"];
		extraModulePackages = with config.boot.kernelPackages; [
			#callPackage ./ch340.nix {}; 
			v4l2loopback
		];
		blacklistedKernelModules = [
			"nouveau"
		];
		kernelParams = [ 
			"nvidia-drm.modeset=1"
			"nvme_core.default_ps_max_latency_us=0" 
			"nvidia-drm.fbdev=1"
			"v4l2loopback.exclusive_caps=1"
			"intel_idle.max_cstate=1"
			"nvidia.NVreg_EnablePCIeGen3=1"
			"nvidia.NVreg_UsePageAttributeTable=1"
			"nvidia-modeset.hdmi_deepcolor=1"
		];
		#kernelPackages = pkgs.linuxPackages_xanmod_stable;
		kernelPackages = pkgs.linuxPackages_cachyos;
		kernel.sysctl = {
			"vm.max_map_count" = 2147483642;
		};
	};
	environment.systemPackages =  [ pkgs.scx ];
}
