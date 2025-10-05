{
  lib,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos-lto.cachyOverride {
      mArch = "NATIVE";
      ticksHz = 1000;
    };
    kernelParams = [
      "mitigations=off"
    ];
  };

  environment.variables = {
    __GL_VRR_ALLOWED = 1;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NixUwU";
      fsType = "btrfs";
      options = ["subvol=root" "noatime"];
    };
    "/home" = {
      device = "/dev/disk/by-label/NixUwU";
      fsType = "btrfs";
      options = ["noatime" "subvol=home"];
    };
    "/nix" = {
      device = "/dev/disk/by-label/NixUwU";
      fsType = "btrfs";
      options = ["noatime" "subvol=nix"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/DE88-5AAD";
      fsType = "vfat";
    };
    "/home/moxie/Music" = {
      device = "/dev/disk/by-uuid/bc5ec750-0252-4151-9c43-1a9a23e92803";
      fsType = "btrfs";
      options = ["subvol=music" "nofail"];
    };
    "/mnt/the_store" = {
      device = "/dev/disk/by-uuid/bc5ec750-0252-4151-9c43-1a9a23e92803";
      fsType = "btrfs";
      options = ["nofail"];
    };
    "/mnt/steam" = {
      device = "/dev/disk/by-uuid/2e12ea4b-e269-4b6e-b592-e4954ba694e7";
      fsType = "f2fs";
      options = ["nofail"];
    };
  };

  hardware.cpu.intel.updateMicrocode = true;

  moxie.graphics.nvidia.enable = true;

  networking.hostName = "nixUwU";
  nix.settings.system-features = ["gccarch-x86-64-v3"];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  powerManagement.cpuFreqGovernor = "performance";

  services = {
    hardware.openrgb.motherboard = "intel";
    pipewire.extraConfig = {
      pipewire."92-bit-perfect" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.allowed-rates" = [44100 48000 96000 192000];
        };
        "stream.properties" = {
          "resample.disable" = true;
        };
      };
    };
  };
}
