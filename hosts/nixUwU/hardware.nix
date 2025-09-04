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

  services = {
    hardware.openrgb.motherboard = "intel";
    xserver.videoDrivers = ["nvidia"];
  };

  powerManagement.cpuFreqGovernor = "performance";

  hardware = {
    enableAllFirmware = true;

    cpu = {
      x86.msr.enable = true;
      intel.updateMicrocode = true;
    };

    graphics.extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];

    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    opentabletdriver.enable = true;
    ckb-next.enable = true;
  };
}
