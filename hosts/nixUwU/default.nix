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

  networking.hostName = "nixUwU";

  security.tpm2.enable = true;

  services.fstrim.enable = true;

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
    NVD_BACKEND = "direct";
  };

  boot = {
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
    extraModprobeConfig = ''
      options nvidia NVreg_EnablePCIeGen3=1 NVreg_UsePageAttributeTable=1 NVreg_NvAGP=1 NVreg_EnableAGPFW=1
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];
    };
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 10000000;
    };
    kernelParams = [
      "video=DP-1:3840x2160@98D"
      "video=HDMI-A-1:1920x1080@60D"
    ];
  };

  systemd.services = {
    "fbset" = {
      wantedBy = ["default.target"];
      description = "set fb size";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.fbset}/bin/fbset -xres 3840 -yres 2160";
      };
    };
  };

  # set a static ip
  networking = {
    useDHCP = false;
    interfaces.eno2.ipv4.addresses = [
      {
        address = "172.31.11.111";
        prefixLength = 24;
      }
    ];
    defaultGateway = {
      address = "172.31.11.1";
      interface = "eno2";
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
