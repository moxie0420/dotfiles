{pkgs, ...}: {
  boot = {
    bootspec.enable = true;

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4"];
    };

    # use latest zen kernel
    kernelPackages = pkgs.linuxPackages_zen;

    consoleLogLevel = 0;
    kernelParams = [];

    loader = {
      # systemd-boot on UEFI
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        consoleMode = "max";
        editor = false;
        enable = true;
      };
      timeout = 0;
    };

    tmp.cleanOnBoot = true;
  };
}
