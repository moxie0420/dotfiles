{system, ...}: {
  system.boot = {
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
          ];

          plymouth.enable = true;
        };
      };
    };
    nixos = {pkgs, ...}: {
      boot = {
        initrd.systemd = {
          enable = true;
          network.wait-online.enable = false;
        };

        kernel.sysfs.kernel.mm.transparent_hugepage = {
          defrag = "defer";
          enabled = "always";
          shmem_enabled = "within_size";
        };

        loader = {
          efi.canTouchEfiVariables = true;
          # limine ans bootloader
          limine = {
            enable = true;
            package = pkgs.limine-full;
            resolution = "1920x1080";
          };
          timeout = 3;
        };
        tmp.cleanOnBoot = true;
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
}
