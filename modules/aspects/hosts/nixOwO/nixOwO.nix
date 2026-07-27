{
  den,
  desktop,
  hardware,
  programs,
  services,
  ...
}: {
  den.aspects.nixOwO = {
    includes = [
      desktop.niri

      den.aspects.gaming
      den.aspects.gaming.extraLaunchers

      hardware.bluetooth
      hardware.corsair
      hardware.nvidia
      hardware.nvidia.prime
      hardware.yubikey

      programs.discord
      programs.firefox
      programs.kitty
      programs.nautilus
      programs.waybar

      services.lact
    ];

    nixos = {pkgs, ...}: {
      boot = {
        initrd.luks.devices."nixroot" = {
          allowDiscards = true;
          device = "/dev/nvme0n1p3";
        };

        kernelParams = ["resume_offset=474218496"];
        resumeDevice = "/dev/disk/by-uuid/a64f2ea2-de99-4f4b-8c94-df6a92fc5db9";
        zfs.forceImportRoot = false;
      };

      fileSystems = {
        "/" = {
          device = "/dev/mapper/nixroot";
          fsType = "ext4";

          options = [
            "defaults"
            "noatime"
          ];
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/A2D3-7B50";
          fsType = "vfat";
        };
      };

      hardware = {
        facter.reportPath = ./nixOwO-facter.json;

        nvidia.prime = {
          amdgpuBusId = "PCI:5:0:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };

      services.fwupd.enable = true;

      swapDevices = [
        {
          device = "/swapfile";
          size = 64 * 1024;
        }
      ];

      systemd.tmpfiles.rules = [
        "w /sys/power/image_size - - - 320000000000"
        "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
      ];
    };
  };
}
