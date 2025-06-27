{
  services.fstrim.enable = true;
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
    "/swap" = {
      device = "/dev/disk/by-label/NixUwU";
      fsType = "btrfs";
      options = ["noatime" "subvol=swap" "nofail"];
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
  swapDevices = [{device = "/swap/swapfile";}];
}
