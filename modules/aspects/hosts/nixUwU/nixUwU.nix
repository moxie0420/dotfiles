{
  den,
  desktop,
  hardware,
  programs,
  services,
  system,
  ...
}: {
  # host aspect
  den.aspects.nixUwU = {
    # required ports
    firewall = let
      torrentPorts = [
        64620
        9000
      ];
    in {
      tcpPorts = torrentPorts;
      udpPorts = torrentPorts;
    };

    includes = [
      den.aspects.nixUwU.network

      system.hostfile
      system.network.tailscale

      desktop.niri

      den.aspects.gaming
      den.aspects.gaming.extraLaunchers
      den.aspects.theme

      hardware.bluetooth
      hardware.corsair
      hardware.nvidia

      # nvidia containers
      den.aspects.containers.nvidia

      programs.discord
      programs.firefox
      programs.flatpak
      programs.kitty
      programs.nautilus
      programs.regreet
      programs.waybar

      services.arrstack
      services.authentik
      services.caddy
      services.caddy.nixUwU
      services.caddy.secret
      services.immich
      # build broken rn TODO: enable when the build is fixed
      # services.lact
      services.pixiecore
      services.vaultwarden
    ];

    # host NixOS configuration
    nixos = {
      lib,
      pkgs,
      ...
    }: {
      boot = {
        binfmt.emulatedSystems = ["aarch64-linux"];

        initrd = {
          kernelModules = [
            # FDE modules
            "aesni_intel"
            "cryptd"
          ];

          luks.devices = {
            "nixroot-A".device = "/dev/disk/by-uuid/f83f89a2-d3ee-41fe-baa2-158dfffae084";
            "nixroot-B".device = "/dev/disk/by-uuid/c0f9aa2e-12ca-4ed4-8e7d-ffc4e6a53af1";
          };
        };

        zfs.forceImportRoot = false;
      };

      environment.systemPackages = builtins.attrValues {
        inherit
          (pkgs)
          gnome-disk-utility
          lm_sensors
          ;
      };

      fileSystems = let
        defaults = extra:
          lib.flatten [
            "noatime"
            "space_cache=v2"
            "compress=zstd"
            extra
          ];
      in {
        # NixUwU root raid-0
        "/" = {
          device = "/dev/disk/by-label/NixUwU";
          fsType = "btrfs";

          options = [
            "noatime"
            "space_cache=v2"
            "subvol=root"
            "x-gvfs-show"
            "ssd"
          ];
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/DE88-5AAD";
          fsType = "vfat";

          options = [
            "fmask=0077"
            "dmask=0077"
            "defaults"
          ];
        };

        "/home" = {
          device = "/dev/disk/by-label/NixUwU";
          fsType = "btrfs";

          options = defaults [
            "subvol=home"
            "ssd"
          ];
        };

        # The store raid-5 array
        "/mnt/the_store" = {
          device = "/dev/disk/by-uuid/bc5ec750-0252-4151-9c43-1a9a23e92803";
          fsType = "btrfs";

          options = defaults [
            "users"
            "nofail"
            "exec"
            "x-gvfs-show"
            "nossd"
          ];
        };

        "/nix" = {
          device = "/dev/disk/by-label/NixUwU";
          fsType = "btrfs";

          options = defaults [
            "subvol=nix"
            "ssd"
          ];
        };
      };

      hardware.facter.reportPath = ./nixUwU-facter.json;

      networking.nameservers = lib.mkBefore [
        "192.168.50.138"
      ];

      powerManagement.powertop.enable = lib.mkForce false;
      programs.gamescope.args = ["-r 75"];

      services = {
        beesd.filesystems.the_store = {
          extraOptions = [
            "--loadavg-target"
            "5.0"
          ];

          hashTableSizeMB = 4096;
          spec = "/mnt/the_store";
        };

        fstrim.enable = true;
        hardware.openrgb.motherboard = "intel";

        pipewire.extraConfig.pipewire = {
          "95-low-latency"."context.properties" = {
            "channelmix.mix-lfe" = true;
            "default.clock.max-quantum" = 256;
            "default.clock.min-quantum" = 256;
            "default.clock.quantum" = 256;
            "default.clock.rate" = 48000;
            "node.pause-on-idle" = false;
          };
        };
      };

      zramSwap.enable = true;
    };
  };
}
