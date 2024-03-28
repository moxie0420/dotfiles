{ config, pkgs, ... }:
{ 
	boot = {
		hardwareScan = true;
		loader = {
			timeout = 0;
			systemd-boot = {
				enable = true;
				editor = true;
				configurationLimit = 5;
				memtest86.enable = false;
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
			availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "uas" "sd_mod"  "vfio-pci" ];
  			kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
			compressor = "zstd";
			compressorArgs = [
				"-19"
				"-T0"
			];
			systemd.enable = true;
			
		};
  		kernelModules = [ "kvm-intel" "v4l2loopback"];
		extraModulePackages = with pkgs.linuxKernel.packages; [
			#callPackage ./ch340.nix {}; 
			linux_6_8.v4l2loopback
		];
		blacklistedKernelModules = [
			"nouveau"
		];
		kernelParams = [
			"intel_iommu=on"
			"iommu=pt"
			"nvidia-drm.fbdev=1"
			"v4l2loopback.exclusive_caps=1"
			"nvidia.NVreg_EnablePCIeGen3=1"
			"nvidia.NVreg_UsePageAttributeTable=1"
			"video=DP-1:3840x2160@144D"
			#"nouveau.config=NvGspRm=1"
		];
		kernelPackages = pkgs.linuxPackages_6_8;
		kernelPatches = [
			{
				name = "add-acs-overrides";
        		patch = pkgs.fetchurl {
          			name = "add-acs-overrides.patch";
          			url = "https://raw.githubusercontent.com/benbaker76/linux-acs-override/main/6.3/acso.patch";
          			sha256 = "sha256-bsi4UIasDn3ErP7MH8ooi4+DOY1AvptqHJ4fzt8ejvQ=";
        		};
			}
		];
		kernel.sysctl = {
			"vm.max_map_count" = 2147483642;
		};
		supportedFilesystems = [ "ntfs" ];
	};
	environment.systemPackages =  [ pkgs.scx ];
}
