{pkgs, ...}: {
  boot = {
    bootspec.enable = true;

    initrd = {
      systemd = {
        enable = true;
        dbus.enable = true;
      };
      supportedFilesystems = ["ext4"];
    };

    # use latest zen kernel
    kernelPackages = pkgs.linuxPackages_zen;

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
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
  };
}
