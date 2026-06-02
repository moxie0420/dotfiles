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
      desktop.keyring
      desktop.niri
      desktop.waybar

      den.aspects.gaming
      den.aspects.gaming.extraLaunchers

      hardware.bluetooth
      hardware.corsair
      hardware.nvidia

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
      programs.tealdeer
      programs.wine

      services.lact
    ];

    nixos = {pkgs, ...}: {
      boot = {
        initrd.luks.devices."nixroot" = {
          device = "/dev/nvme0n1p3";
          allowDiscards = true;
        };

        kernelParams = ["resume_offset=474218496"];
        resumeDevice = "/dev/disk/by-uuid/a64f2ea2-de99-4f4b-8c94-df6a92fc5db9";
      };

      hardware.facter.reportPath = ./nixOwO-facter.json;

      fileSystems = {
        "/" = {
          device = "/dev/mapper/nixroot";
          fsType = "ext4";
          options = ["defaults" "noatime"];
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/A2D3-7B50";
          fsType = "vfat";
        };
      };

      hardware = {
        nvidia = {
          prime = {
            offload = {
              enable = true;
              enableOffloadCmd = true;
            };
            nvidiaBusId = "PCI:1:0:0";
            amdgpuBusId = "PCI:5:0:0";
          };
          powerManagement = {
            enable = true;
            finegrained = true;
          };
        };
      };

      swapDevices = [
        {
          device = "/swapfile";
          size = 64 * 1024;
          priority = 0;

          encrypted = {
            enable = true;
            label = "nixroot";
            blkDev = "/dev/nvme0n1p3";
          };
        }
      ];

      systemd.tmpfiles.rules = [
        "w /sys/power/image_size - - - 320000000000"
        "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
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
      programs.tealdeer
      programs.wine
    ];
  };
}
