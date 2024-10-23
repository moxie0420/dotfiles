{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./disks.nix
    ./hardware.nix
  ];

  environment.variables.FLAKE = "/etc/nixos";

  networking.hostName = "nixUwU";

  security.tpm2.enable = true;

  services.fstrim.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
    NVD_BACKEND = "direct";
  };

  boot = {
    blacklistedKernelModules = [
      "nouveau"
    ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    extraModprobeConfig = ''
      options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3"
      options nvidia NVreg_EnablePCIeGen3=1 NVreg_UsePageAttributeTable=1
      options nvidia-drm fbdev=1
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "uas" "sd_mod" "vfio-pci"];
      systemd.enable = true;
    };
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 10000000;
    };
  };

  systemd = {
    # set a static ip
    network.networks."10-wan" = {
      matchConfig.Name = "eno2";
      address = [
        "172.31.11.103"
      ];
      routes = [
        {Gateway = "172.31.11.1";}
      ];
      linkConfig.RequiredForOnline = "routable";
    };

    services.tty-fix = {
      enable = true;
      wantedBy = ["multi-user.target"];
      description = "fixes tty resolution";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.fbset}/bin/fbset -xres 3840 -yres 2160";
      };
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
