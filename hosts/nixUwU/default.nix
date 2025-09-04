{...}: {
  imports = [
    ./audio.nix
    ./disks.nix
    ./hardware.nix
  ];

  environment = {
    variables = {
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_GSYNC_ALLOWED = "1";
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      VDPAU_DRIVER = "nvidia";
      NVD_BACKEND = "direct";
    };
  };

  boot = {
    initrd = {
      kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "sd_mod"
      ];
    };
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 10000000;
    };
    consoleLogLevel = 3;
    kernelParams = [
      "vt.global_cursor_default=0"
    ];
    kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
      "adm1021"
      "nct6775"
    ];
    blacklistedKernelModules = [
      "acpi_cpufreq"
    ];

    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    supportedFilesystems = ["ntfs" "btrfs"];
  };

  networking.hostName = "nixUwU";
}
