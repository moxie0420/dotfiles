{ config, lib, pkgs, ... }:
{
  nixpkgs = {
		hostPlatform = lib.mkDefault "x86_64-linux";
		config.allowUnfree = true;
	};

  systemd.targets = {
		sleep.enable = true;
		suspend.enable = true;
		hibernate.enable = true;
		hybrid-sleep.enable = true;
	};
  	
	powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
	powerManagement.enable = true;

	services.xserver.videoDrivers = [ "intel" "nvidia" ];
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
				open = true;
				nvidiaSettings = true;
				package = config.boot.kernelPackages.nvidiaPackages.beta;
				prime = {
					offload = {
						enable = false;
						enableOffloadCmd = true;
					};
					reverseSync.enable = true;
					sync.enable = false;

					intelBusId = "PCI:0:2:0";
					nvidiaBusId = "PCI:1:0:0";
				};
  		};
  		opentabletdriver.enable = true;
	};
	chaotic.mesa-git.enable = false;
}
