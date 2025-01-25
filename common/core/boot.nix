{
  pkgs,
  lib,
  ...
}: {
  boot = {
    bootspec.enable = true;

    binfmt.emulatedSystems = ["aarch64-linux"];

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4"];
      verbose = false;
    };

    # use latest zen kernel
    kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;

    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

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

    plymouth.enable = true;

    tmp.cleanOnBoot = true;
  };
}
