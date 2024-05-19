{ config, pkgs, ... }:

{
	powerManagement = {
		cpuFreqGovernor = "powersave";
		powertop.enable = true;
	};
	services = {
		libinput.enable = true;
		xserver = {
			videoDrivers = [ "amdgpu" "nvidia" ];
		};
		udev.extraRules = ''
			 # Remove NVIDIA USB xHCI Host Controller devices, if present
    		ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"

    		# Remove NVIDIA USB Type-C UCSI devices, if present
    		ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"

    		# Remove NVIDIA Audio devices, if present
    		ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"

    		# Remove NVIDIA VGA/3D controller devices
    		ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
		'';
	};

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
			extraPackages = with pkgs; [
				rocm-opencl-icd
				rocm-opencl-runtime
				vaapiVdpau
			];
		};
		nvidia = {
			open = false;
			nvidiaSettings = false;
			modesetting.enable = true;
			package = config.boot.kernelPackages.nvidiaPackages.beta;

			prime = {
				reverseSync.enable = true;
				offload = {
					enable = true;
					enableOffloadCmd = true;
				};
				nvidiaBusId = "PCI:1:0:0";
				amdgpuBusId = "PCI:5:0:0";
			};
			powerManagement = {
				enable = true;
				finegrained = false;
			};
		};
	};
}
