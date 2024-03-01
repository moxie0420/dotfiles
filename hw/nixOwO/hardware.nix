{ config, ... }:

{
	powerManagement = {
		cpuFreqGovernor = "powersave";
		powertop.enable = true;
	};
	services.xserver.videoDrivers = [ "amdgpu" /*"nvidia"*/ "nouveau" ];
	chaotic.mesa-git.enable = true;
	hardware = {
		enableAllFirmware = true;
		cpu.amd = {
			updateMicrocode = true;
			sev.enable = true;
		};
		opentabletdriver.enable = true;
		ksm.enable = true;

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

			prime = {nouveau
				reverseSync.enable = true;
				offload.enable = true;
				sync.enable = false;
				nvidiaBusId = "PCI:1:0:0";
				amdgpuBusId = "PCI:5:0:0";
			};
			powerManagement = {
				enable = true;
				finegrained = true;
			};
		};
	};
}
