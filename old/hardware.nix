{ config, lib, pkgs, ... }:

{
	powerManagement = {
		cpuFreqGovernor = "powersave";
		powertop.enable = true;
	};
	hardware = {
		enableAllFirmware = true;
		enableRedistributableFirmware = config.hardware.enableAllFirmware;
		cpu.amd.updateMicrocode = true;
		opentabletdriver.enable = true;
		bluetooth.enable = false;
		ksm.enable = true;
		deviceTree.enable = true;

		opengl = {
			enable = true;
			driSupport = true;
			driSupport32Bit = true;
		};
		nvidia = {
			open = false;
			nvidiaSettings = false;
			modesetting.enable = true;
			package = config.boot.kernelPackages.nvidiaPackages.beta;

			prime = {
				reverseSync.enable = true;
				offload.enable = true;
				sync.enable = false;
				nvidiaBusId = "PCI:1:0:0";
				amdgpuBusId = "PCI:5:0:0";
			};
			powerManagement = {
				enable = false;
				finegrained = true;
			};
		};
	};
}
