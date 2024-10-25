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

  environment = {
    loginShellInit = ''
      ${pkgs.fbset}/bin/fbset -xres 3840 -yres 2160
    '';
    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_GSYNC_ALLOWED = "1";
      NVD_BACKEND = "direct";
    };
  };

  boot = {
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
    extraModprobeConfig = ''
      options nvidia NVreg_EnablePCIeGen3=1 NVreg_UsePageAttributeTable=1 NVreg_NvAGP=1 NVreg_EnableAGPFW=1
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "sd_mod"];
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

    watchdog = {
      device = "/dev/watchdog";
      rebootTime = "5m";
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
