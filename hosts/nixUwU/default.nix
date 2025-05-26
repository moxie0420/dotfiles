{
  config,
  self,
  pkgs,
  ...
}: {
  imports = [
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
    kernelPackages = pkgs.linuxPackages_cachyos;

    extraModulePackages = let
      alsa-quadcapture = pkgs.callPackage ../../packages/alsa-quadcapture.nix {
        inherit (config.boot.kernelPackages) kernel;
      };
    in [
      alsa-quadcapture
    ];

    plymouth = {
      theme = "blahaj";
      themePackages = with pkgs; [
        plymouth-blahaj-theme
      ];
    };
    supportedFilesystems = ["ntfs"];
  };

  # set a static ip
  networking.hostName = "nixUwU";
  networking = {
    useDHCP = true;
  };

  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/main.lua.d/99-alsa-lowlatency.lua" ''
        alsa_monitor.rules = {
        {
          matches = {{{ "node.name", "matches", "alsa_output.*" }}};
          apply_properties = {
            ["audio.format"] = "S32LE",
            ["audio.rate"] = "96000", -- for USB soundcards it should be twice your desired rate
            ["api.alsa.period-size"] = 32, -- defaults to 1024, tweak by trial-and-error
            -- ["api.alsa.disable-batch"] = true, -- generally, USB soundcards use the batch mode
          },
        },
      }
    '')
  ];

  systemd.services.nvidia-overclock = {
    wantedBy = ["default.target"];
    description = "Overclocks your Nvidia GPU";
    serviceConfig = {
      Type = "oneshot";
    };
    script = "${self.packages.${pkgs.system}.nvidia-oc}/bin/nvidia-oc";
  };

  virtualisation.waydroid.enable = true;
}
