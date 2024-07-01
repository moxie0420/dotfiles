{...}: {
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
    "/media/zoomer" = {
      device = "/dev/disk/by-uuid/d033e2a3-fb9c-4d5b-813b-93296b3b9b90";
      fsType = "ext4";
      options = ["defaults" "noatime"];
    };
  };
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/c9947b18-c60d-4b5f-adce-0d336f7e7f9f";
    }
  ];
}
