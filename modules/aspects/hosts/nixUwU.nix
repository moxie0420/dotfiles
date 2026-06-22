{
  den,
  desktop,
  hardware,
  programs,
  services,
  ...
}: {
  # host aspect
  den.aspects.nixUwU = {
    includes = [
      desktop.keyring
      desktop.niri
      desktop.waybar

      den.aspects.gaming
      den.aspects.gaming.extraLaunchers

      hardware.bluetooth
      hardware.corsair
      hardware.nvidia

      # nvidia containers
      den.aspects.containers.internal-nat
      den.aspects.containers.nvidia

      programs.btop
      programs.discord
      programs.firefox
      programs.fzf
      programs.hyfetch
      programs.kitty
      programs.nautilus
      programs.obs-studio
      programs.ripgrep
      programs.starship
      programs.wine

      services.arrstack
      services.authentik
      services.caddy
      services.caddy.secret
      services.forgejo.containerized
      services.immich
      services.lact
      services.vaultwarden
    ];

    # required ports
    firewall.ports = let
      torrentPort = [64620];
    in {
      tcp = torrentPort;
      udp = torrentPort;
    };

    # host NixOS configuration
    nixos = {
      config,
      lib,
      pkgs,
      ...
    }: {
      boot.initrd = {
        availableKernelModules = [
          # Defaults
          "xhci_pci"
          "ahci"
          "nvme"
          "usb_storage"
          "usbhid"
          "sd_mod"

          # FDE modules
          "aesni_intel"
          "cryptd"
        ];
        kernelModules = [
          # "adm1021"
          "coretemp"
          "nct6775"
        ];

        luks.devices = {
          "nixroot-A".device = "/dev/disk/by-uuid/f83f89a2-d3ee-41fe-baa2-158dfffae084";
          "nixroot-B".device = "/dev/disk/by-uuid/c0f9aa2e-12ca-4ed4-8e7d-ffc4e6a53af1";
        };
      };

      environment = {
        etc."sysconfig/lm_sensors".text = ''
          HWMON_MODULES="adm1021 coretemp nct6775"
        '';

        systemPackages = builtins.attrValues {
          inherit (pkgs) lm_sensors;
        };
      };

      fileSystems = let
        btrfs = {
          hdd = ["nodiscard" "nossd"];
          ssd = ["discard" "ssd"];

          large = ["space_cache=v2"];
        };

        defaults = extra: lib.flatten ["noatime" extra];
      in {
        "/" = {
          device = "/dev/disk/by-label/NixUwU";
          fsType = "btrfs";
          options = defaults ["subvol=root" "x-gvfs-show" btrfs.ssd "compress=zstd"];
        };
        "/home" = {
          device = "/dev/disk/by-label/NixUwU";
          fsType = "btrfs";
          options = defaults ["subvol=home" btrfs.ssd "compress=zstd"];
        };
        "/nix" = {
          device = "/dev/disk/by-label/NixUwU";
          fsType = "btrfs";
          options = defaults ["subvol=nix" btrfs.ssd "compress=zstd"];
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/DE88-5AAD";
          fsType = "vfat";
          options = ["fmask=0077" "dmask=0077" "defaults"];
        };
        "/mnt/the_store" = {
          device = "/dev/disk/by-uuid/bc5ec750-0252-4151-9c43-1a9a23e92803";
          fsType = "btrfs";
          options = defaults ["users" "nofail" "exec" "x-gvfs-show" btrfs.hdd btrfs.large "compress=zstd"];
        };
      };

      hardware.facter.reportPath = ./nixUwU-facter.json;

      powerManagement.powertop.postStart = ''
        ${lib.getExe' config.systemd.package "udevadm"} trigger -c bind -s usb -a idVendor=320f -a idProduct=504b
        ${lib.getExe' config.systemd.package "udevadm"} trigger -c bind -s usb -a idVendor=1b1c -a idProduct=504b
      '';

      services = {
        beesd.filesystems.the_store = {
          spec = "/mnt/the_store";
          hashTableSizeMB = 4096;
          extraOptions = ["--loadavg-target" "5.0"];
        };

        fstrim.enable = true;
        hardware.openrgb.motherboard = "intel";

        pipewire = {
          extraConfig.pipewire = {
            "92-bit-perfect"."context.properties"."default.clock.allowed-rates" = [
              44100
              48000
              88200
              96000
            ];

            "92-low-latency" = {
              "context.properties" = {
                "node.pause-on-idle" = false;
                "channelmix.mix-lfe" = true;

                "default.clock.rate" = 48000;
                "default.clock.quantum" = 256;
                "default.clock.min-quantum" = 256;
                "default.clock.max-quantum" = 256;
              };
            };
          };

          wireplumber.extraConfig."uac2-pro-audio"."monitor.alsa.rules" = [
            {
              matches = [
                {
                  node.name = "alsa_output.usb-ZOOM_Corporation_UAC-2_000000000000000000000000200641D4-00*";
                }
              ];
              actions.update-props."device.profile" = "pro-audio";
            }
          ];
        };

        udev.extraRules = ''
          # disable USB auto suspend for Glorious GMMK V2 96 ANSI
          ACTION=="bind", SUBSYSTEM=="usb", ATTR{idVendor}=="320f", ATTR{idProduct}=="504b", TEST=="power/control", ATTR{power/control}="on"
          # disable USB auto suspend for CORSAIR HARPOON RGB PRO Gaming Mouse
          ACTION=="bind", SUBSYSTEM=="usb", ATTR{idVendor}=="1b1c", ATTR{idProduct}=="1b75", TEST=="power/control", ATTR{power/control}="on"
        '';
      };

      swapDevices = [
        {
          device = "/dev/disk/by-uuid/6c4f7e3d-4212-4ec1-938e-2c2f062c285c";
        }
      ];
    };

    # host provides default home environment for its users
    provides.to-users.includes = [
      desktop.keyring
      desktop.niri
      desktop.waybar

      den.aspects.gaming
      den.aspects.gaming.extraLaunchers

      programs.btop
      programs.discord
      programs.firefox
      programs.fzf
      programs.hyfetch
      programs.kitty
      programs.nautilus
      programs.ripgrep
      programs.starship
      programs.wine
    ];
  };
}
