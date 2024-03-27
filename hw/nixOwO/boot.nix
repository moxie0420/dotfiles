{ config, pkgs, lib, ... }:

{
	security.protectKernelImage = false;
	boot = {
		hardwareScan = true;
		bootspec.enable = true;
		
		extraModulePackages = [
			config.boot.kernelPackages.acpi_call
		];
		kernelModules = [ 
			"kvm_amd"
			"acpi_call"
		];
		kernelParams = [ 
			"rootflags=noatime"
			"debugfs=off"
			"logo.nologo"
			"fbcon=nodefer"
			"resume_offset=474218496"
			"acpi_backlight=native"
		];
		blacklistedKernelModules = [ 
			"nouveau"
			"nvidia"
			"nvidia_drm"
			"nvidia_modeset"
		];
		extraModprobeConfig = ''
			blacklist nouveau
			options nouveau modeset=0
		'';
		
		kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
		kernel.sysctl = {
			"kernel.kexec_load_disabled" = lib.mkDefault true;
		};

		tmp.cleanOnBoot = true;
		lanzaboote = {
			enable = true;
			pkiBundle = "/etc/secureboot";
		};
		loader = {
			efi.canTouchEfiVariables = true;
			timeout = 0;
			systemd-boot = {
				editor = false;
				configurationLimit= 5;
				memtest86.enable = false;
			};
		};
		initrd = {
			compressor = "zstd";
			verbose = false;
			availableKernelModules = [ 
				"nvme"
				"xhci_pci"
				"usbhid"
				"sdhci_pci"
			];
			kernelModules = [ "amdgpu" "cryptd" "aesni_intel" "xhci_hcd" ];
			systemd = {
				enable = true;
				dbus.enable = true;
			};
		};
		plymouth = {
			enable = true;
			themePackages = [ pkgs.catppuccin-plymouth ];
		};
		resumeDevice = "/dev/mapper/nixroot";
		enableContainers = true;
	};
	services = {
		fwupd = {
			enable = true;
		};
		logind = {
			lidSwitch = "suspend";
			extraConfig = ''
				HandlePowerKey=hibernate
				HandlePowerKeyLongPress=shutdown
				NAutoVTs=2
			'';
		};
	};
	systemd = {
		extraConfig = ''
			HibernateDelaySec=10m
		'';
		tmpfiles.settings = {
			"hibernate file" = {
				"/sys/power/image_size" = {
					w.argument = "64";
				};
			};
		};
	};
}
