{ config, pkgs, lib, ... }:

{
	security.protectKernelImage = false;
	boot = {
		hardwareScan = true;
		bootspec.enable = true;
		
		kernelModules = [ 
			"kvm_amd"
			"acpi_call"
		];
		kernelParams = [ 
			"rootflags=noatime"
			"debugfs=off"
			"logo.nologo"
			"fbcon=nodefer"
			"acpi_backlight=native"
			"amd_pstate=active"
			"resume_offset=474218496"
			"mem_sleep_default=s2idle"
			"iwlmvm.power_scheme=1"
			"iwlwifi.power_save=0"
		];
		blacklistedKernelModules = [ "nouveau" ];
		
		kernelPackages = lib.mkDefault pkgs.linuxPackages_xanmod_latest;
		kernel.sysctl = {
			"kernel.kexec_load_disabled" = lib.mkDefault true;
		};
		extraModulePackages = with config.boot.kernelPackages; [ 
			acpi_call 
		];

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
				configurationLimit = 5;
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
			prepend = ["${/boot/acpi_override}"];
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
				NAutoVTs=1
			'';
		};
	};
	systemd = {
		extraConfig = ''
			HibernateDelaySec=15m
		'';
		units = {
			"dev-ttyS0.device".enable = false;
			"dev-ttyS1.device".enable = false;
			"dev-ttyS2.device".enable = false;
			"dev-ttyS3.device".enable = false;
		};
		tmpfiles.settings = {
			"hibernate file" = {
				"/sys/power/image_size" = {
					w.argument = "48";
				};
			};
		};
	};
}
