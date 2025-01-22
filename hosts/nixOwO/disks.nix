{
  boot.resumeDevice = "/dev/mapper/nixroot";

  services.fstrim.enable = true;

  systemd.tmpfiles.rules = [
    "w /sys/power/image_size - - - 320000000000"
  ];
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
      device = "/dev/disk/by-uuid/A048-7A0C";
      fsType = "vfat";
    };
  };
  boot.initrd.luks.devices."nixroot" = {
    device = "/dev/nvme0n1p3";
    allowDiscards = true;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 64000;
    }
  ];
}
