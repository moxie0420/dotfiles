{
  config,
  lib,
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

  hardware = {
    enableAllFirmware = true;

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
