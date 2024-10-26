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

    graphics = {
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
      ];
    };

    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      powerManagement.enable = true;
    };

    opentabletdriver.enable = true;
    ckb-next.enable = true;
  };
}
