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
    extraModprobeConfig = ''
      blacklist nouveau
      options nouveau modeset=0
    '';

    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
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
      systemd-boot = {
        editor = false;
        configurationLimit = 5;
      };
    };
    initrd = {
      compressor = "zstd";
      verbose = false;
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "usbhid"
        "sdhci_pci"
      ];
      kernelModules = ["amdgpu" "cryptd" "aesni_intel" "xhci_hcd"];
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
    fwupd = {
      enable = true;
    };
    logind.extraConfig = ''
      HandlePowerKey=shutdown
    '';
  };
  systemd.tmpfiles.settings = {
    "hibernate file" = {
      "/sys/power/image_size" = {
        w.argument = "64";
      };
    };
  };
}
