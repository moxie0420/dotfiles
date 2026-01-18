{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.moxie.hardware;
in {
  options.moxie.hardware = {
    enable = mkEnableOption "Enable my default hw config";
    enableBluetooth = mkEnableOption "Enable my bluetooth config";
    enableMobileDevices = mkEnableOption "Enable mobile device support";
    enableRGB = mkEnableOption "Enable RGB support via openrgb";
    enableVR = mkEnableOption "Enable VR support for the valve index";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      boot.kernelParams = ["mem_sleep_deefault=deep"];

      environment.systemPackages = with pkgs; [
        lm_sensors
        lshw
        pciutils
        usbutils
      ];

      hardware = {
        cpu.x86.msr.enable = true;
        enableAllFirmware = true;
        ksm.enable = true;
      };

      services = {
        fstrim.enable = true;
        power-profiles-daemon.enable = true;
        udisks2 = {
          enable = true;
          mountOnMedia = true;
          settings = {
            "udisks2.conf" = {
              defaults.encryption = "luks2";
              udisks2 = {
                modules = ["*"];
                modules_load_preference = "ondemand";
              };
            };
          };
        };
        upower.enable = true;
      };

      systemd.sleep.extraConfig = ''
        HibernateDelaySec=10m
        SuspendState=mem
      '';

      zramSwap = {
        enable = true;
        algorithm = "zstd lz4 (type=huge)";
        priority = 100;
        memoryPercent = 100;
      };
    })

    (mkIf cfg.enableBluetooth {
      environment.systemPackages = with pkgs; [
        blueberry
      ];

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Experimental = true;
            KernelExperimental = true;
          };
        };
      };

      services.blueman.enable = true;
    })

    (mkIf cfg.enableMobileDevices {
      environment.systemPackages = with pkgs; [
        libimobiledevice
        ifuse
      ];

      services.usbmuxd = {
        enable = true;
        package = pkgs.usbmuxd2;
      };
    })

    (mkIf cfg.enableRGB {
      services.hardware.openrgb = {
        enable = true;
        package = pkgs.openrgb-with-all-plugins;
      };
    })

    (mkIf cfg.enableVR {
      environment.systemPackages = with pkgs; [
        libsurvive
      ];
      services.monado = {
        enable = true;
        defaultRuntime = true;
        forceDefaultRuntime = true;
      };

      systemd.user.services.monado.environment = {
        STEAMVR_LH_ENABLE = "1";
        XRT_COMPOSITOR_COMPUTE = "1";
      };
    })
  ];
}
