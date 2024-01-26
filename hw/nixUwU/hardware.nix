{ config, lib, pkgs, ... }:
{

  	nixpkgs = {
		hostPlatform = lib.mkDefault "x86_64-linux";
		config.allowUnfree = true;
	};

    systemd.targets = {
		sleep.enable = false;
		suspend.enable = false;
		hibernate.enable = false;
		hybrid-sleep.enable = false;
	};
  	
	powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
	powerManagement.enable = false;

	services.xserver.videoDrivers = ["nvidia"];
	hardware = {
  		enableAllFirmware = true;
  		cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  		opengl = {
			enable = true;
			driSupport = true;
			driSupport32Bit = true;
  		};

  		nvidia = {
			modesetting.enable = true;
			open = false;
			nvidiaSettings = false;
			package = config.boot.kernelPackages.nvidiaPackages.beta;
  		};
  		opentabletdriver.enable = true;
	};
}
