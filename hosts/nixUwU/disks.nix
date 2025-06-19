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
    "/boot" = {
      device = "/dev/disk/by-uuid/DE88-5AAD";
      fsType = "vfat";
    };
  };
  swapDevices = [];
}
