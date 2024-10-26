{
  config,
  pkgs,
  ...
}: {
  powerManagement = {
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
  };
  services = {
    libinput.enable = true;
    xserver.videoDrivers = ["amdgpu" "nvidia"];
  };

  hardware = {
    enableAllFirmware = true;
    cpu.amd = {
      updateMicrocode = true;
      sev.enable = true;
    };
    opentabletdriver.enable = true;
    ksm.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        vaapiVdpau
      ];
    };
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
    nvidia = {
      open = true;
      nvidiaSettings = true;
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
        finegrained = true;
      };
    };
  };
}
