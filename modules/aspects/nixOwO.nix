{
  desktop,
  den,
  programs,
  ...
}: {
  den.aspects.nixOwO = {
    includes = builtins.attrValues rec {
      inherit
        (desktop)
        keyring
        niri
        waybar
        ;

      inherit (den.aspects) gaming;
      inherit (gaming) extraLaunchers;

      inherit
        (programs)
        btop
        discord
        firefox
        fzf
        hyfetch
        kitty
        nautilus
        ripgrep
        starship
        tealdeer
        wine
        ;
    };

    nixos = {pkgs, ...}: {
      boot = {
        initrd.luks.devices."nixroot" = {
          device = "/dev/nvme0n1p3";
          allowDiscards = true;
        };

        kernelParams = ["resume_offset=474218496"];
        resumeDevice = "/dev/disk/by-uuid/a64f2ea2-de99-4f4b-8c94-df6a92fc5db9";
      };

      environment.variables.AQ_DRM_DEVICES = "/dev/dri/amd-igpu";

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

      services.udev.extraRules = ''
        KERNEL=="card*", KERNELS=="0000:05:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/amd-igpu"
      '';

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
  };
}
