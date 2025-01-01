{
  self,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./disks.nix
    ./hardware.nix
  ];

  environment = {
    systemPackages = with pkgs; [ddcutil];
    variables = {
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_GSYNC_ALLOWED = "1";
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";

      PROTON_ENABLE_NVAPI = "1";
      PROTON_ENABLE_NGX_UPDATER = "1";

      VKD3D_CONFIG = "dxr11,dxr";
    };
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
    };
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 10000000;
    };
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [
      "plymouth.use-simpledrm"
    ];
  };

  # set a static ip
  networking.hostName = "nixUwU";
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

  systemd.services.nvidia-overclock = {
    wantedBy = ["default.target"];
    description = "Overclocks your Nvidia GPU";
    serviceConfig = {
      Type = "oneshot";
    };
    script = "${self.packages.${pkgs.system}.nvidia-oc}/bin/nvidia-oc";
  };
}
