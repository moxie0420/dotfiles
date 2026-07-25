{inputs, ...}: {
  den.aspects.theHub.disk-config = {
    nixos = {
      imports = [
        inputs.disko.nixosModules.disko
      ];

      disko.devices.disk = {
        main = {
          content = {
            partitions = {
              ESP = {
                content = {
                  format = "vfat";
                  mountOptions = ["umask=0077"];
                  mountpoint = "/boot";
                  type = "filesystem";
                };
                end = "1G";
                name = "ESP";
                priority = 1;
                start = "1M";
                type = "EF00";
              };
              root = {
                content = {
                  # Override existing partition
                  extraArgs = ["-f"];
                  # Subvolumes must set a mountpoint in order to be mounted,
                  # unless their parent is mounted
                  subvolumes = {
                    "@root" = {
                      mountOptions = ["ssd"];
                      mountpoint = "/";
                    };
                    "@root/home" = {
                      mountOptions = ["compress=zstd"];
                      mountpoint = "/home";
                    };
                    "@root/home/madelyn" = {};
                    "@root/nix" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/nix";
                    };
                  };
                  type = "btrfs";
                };
                size = "100%";
              };
              swap = {
                content = {
                  discardPolicy = "both";
                  type = "swap";
                };
                size = "32G";
              };
            };
            type = "gpt";
          };
          device = "/dev/disk/by-id/ata-INTEL_SSDSC2BF180A4H_CVDA331500PL1802GN";
          type = "disk";
        };

        storage = {
          content = {
            partitions.storage-1 = {
              content = {
                # Override existing partition
                extraArgs = ["-f"];
                mountOptions = [
                  "hdd"
                ];
                subvolumes = {
                  "@storage".mountpoint = "/media/storage";
                  "@storage/Documents".mountpoint = "/media/storage/Documents";
                  "@storage/Music".mountpoint = "/media/storage/Music";
                  "@storage/Potos".mountpoint = "/media/storage/Photos";
                  "@storage/Videos".mountpoint = "/media/storage/Videos";
                };
                type = "btrfs";
              };
              size = "100%";
            };
            type = "gpt";
          };
          device = "/dev/disk/by-id/ata-ST1000NM0011_Z1N0FKSA";
          type = "disk";
        };
      };
    };
  };
  flake-file.inputs.disko = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:nix-community/disko/latest";
  };
}
