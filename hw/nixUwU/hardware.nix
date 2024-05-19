{
  config,
  lib,
  pkgs,
  ...
}: {
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  powerManagement = {
    powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "performance";
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
      ];
    };

    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    opentabletdriver.enable = true;
  };
  chaotic.mesa-git.enable = false;
}
