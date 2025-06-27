{
  self,
  pkgs,
  ...
}: {
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
      NVD_BACKEND = "direct";
    };
  };

  boot = {
    initrd = {
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
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [
      "adm1021"
      "nct6775"
    ];

    plymouth = {
      theme = "blahaj";
      themePackages = with pkgs; [
        plymouth-blahaj-theme
      ];
    };
    supportedFilesystems = ["ntfs" "btrfs"];
  };

  # set a static ip
  networking.hostName = "nixUwU";
  networking = {
    useDHCP = true;
  };

  systemd.services.nvidia-overclock = {
    wantedBy = ["default.target"];
    description = "Overclocks your Nvidia GPU";
    serviceConfig = {
      Type = "oneshot";
    };
    script = "${self.packages.${pkgs.system}.nvidia-oc}/bin/nvidia-oc";
  };

  virtualisation.waydroid.enable = false;
}
