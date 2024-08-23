{
  config,
  pkgs,
  lib,
  ...
}: {
  security.protectKernelImage = false;
  boot = {
    hardwareScan = true;
    bootspec.enable = true;
    kernelModules = [
      "kvm_amd"
      "amdgpu"
      "nvme"
    ];
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "rootflags=noatime"
      "resume_offset=474218496"
      "acpi_backlight=native"
    ];
    blacklistedKernelModules = [
      "nouveau"
      "nvidia"
      "nvidia_drm"
      "nvidia_modeset"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = {
      "kernel.kexec_load_disabled" = lib.mkDefault true;
    };

    tmp.cleanOnBoot = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 0;
      systemd-boot.editor = false;
    };
    initrd = {
      compressor = "zstd";
      verbose = false;
      availableKernelModules = [
        "xhci_pci"
        "usbhid"
        "sdhci_pci"
        "cryptd"
        "aesni_intel"
        "xhci_hcd"
      ];
      systemd = {
        enable = true;
        dbus.enable = true;
      };
    };
    plymouth = {
      enable = true;
    };
    resumeDevice = "/dev/mapper/nixroot";
    enableContainers = true;
  };
  services = {
    fwupd.enable = true;
    logind.extraConfig = ''
      HandlePowerKey=shutdown
    '';
  };
  systemd.tmpfiles.settings = {
    "hibernate file" = {
      "/sys/power/image_size" = {
        w.argument = "320000000000";
      };
    };
  };
}
