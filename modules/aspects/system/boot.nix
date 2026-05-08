{system, ...}: {
  system.boot = {
    nixos.boot = {
      initrd = {
        systemd = {
          enable = true;
          network.wait-online.enable = false;
        };

        # ensure initrd can mount root
        supportedFilesystems = ["btrfs"];
      };

      kernel.sysfs.kernel.mm.transparent_hugepage = {
        enabled = "always";
        defrag = "defer";
        shmem_enabled = "within_size";
      };

      loader = {
        efi.canTouchEfiVariables = true;
        # limine ans bootloader
        limine = {
          enable = true;
          resolution = "1920x1080";
        };
        timeout = 3;
      };
      tmp.cleanOnBoot = true;
    };

    provides = {
      graphical = {
        nixos = {lib, ...}: {
          boot = {
            consoleLogLevel = lib.mkForce 3;
            initrd.verbose = lib.mkForce false;

            # kernel params for quiet boot
            kernelParams = [
              "quiet"
              "splash"
              "boot.shell_on_fail"
              "udev.log_level=3"
              "rd.systemd.show_status=auto"

              # Zswap
              "zswap.enabled=1" # enables zswap
              "zswap.compressor=lz4" # compression algorithm
              "zswap.max_pool_percent=20" # maximum percentage of RAM that zswap is allowed to use
              "zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure
            ];

            plymouth.enable = true;
          };
        };
      };

      secure = {
        includes = [system.boot];
        nixos = {pkgs, ...}: {
          boot.loader.limine.secureBoot.enable = true;
          environment.systemPackages = [pkgs.sbctl];
        };
      };
    };
  };
}
