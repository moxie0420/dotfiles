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
  			kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
			compressor = "lz4";
			systemd.enable = true;
		};
  		kernelModules = [ "kvm-intel" "v4l2loopback"];
		extraModulePackages = with config.boot.kernelPackages; [
			#callPackage ./ch340.nix {}; 
			v4l2loopback
		];
		blacklistedKernelModules = [
			#"nouveau"
		];
		kernelParams = [
			"nvme_core.default_ps_max_latency_us=0" 
			#"nvidia-drm.fbdev=1"
			"v4l2loopback.exclusive_caps=1"
			"nvidia.NVreg_EnablePCIeGen3=1"
			"nvidia.NVreg_UsePageAttributeTable=1"
			"video=DP-1:3840x2160@144D"
			"video=HDMI-A-2:1360x768@60D"
		];
		kernelPackages = pkgs.linuxPackages_cachyos;
		kernel.sysctl = {
			"vm.max_map_count" = 2147483642;
		};
	};
	environment.systemPackages =  [ pkgs.scx ];
}
