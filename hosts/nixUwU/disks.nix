{...}: {
  systemd.tmpfiles.rules = [
    "d /media/The_Store 0770 moxie users -"
    "w /sys/power/image_size - - - 160000000000"
  ];
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/c0de85f9-7225-44d9-a30f-4d039b73968d";
      fsType = "ext4";
      options = ["defaults" "noatime"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/CEBC-2F92";
      fsType = "vfat";
    };
    "/media/ryan-gosling" = {
      device = "/dev/disk/by-uuid/250dc6f8-6cf8-4dc1-ae12-9cd37f36f6fd";
      fsType = "ext4";
      options = ["defaults" "noatime"];
    };
    "/media/The_Store" = {
      device = "/dev/disk/by-uuid/bc5ec750-0252-4151-9c43-1a9a23e92803";
      fsType = "btrfs";
      options = ["defaults" "nofail" "compress=zstd" "noatime"];
    };
    "/media/steam" = {
      device = "/dev/disk/by-uuid/2e12ea4b-e269-4b6e-b592-e4954ba694e7";
      fsType = "f2fs";
      options = ["defaults" "noatime"];
    };
  };
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/a85b10e8-36dd-47c0-a836-3c5fe29c7b4d";
    }
  ];
}
