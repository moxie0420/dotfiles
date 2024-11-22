{pkgs, ...}: let
  monitors = pkgs.writeText "monitors.xml" ''
    <monitors version="2">
      <configuration>
        <layoutmode>physical</layoutmode>
        <logicalmonitor>
          <x>3840</x>
          <y>0</y>
          <scale>1</scale>
          <monitor>
            <monitorspec>
              <connector>HDMI-1</connector>
              <vendor>SAM</vendor>
              <product>SyncMaster</product>
              <serial>0x00000000</serial>
            </monitorspec>
            <mode>
              <width>1920</width>
              <height>1080</height>
              <rate>60.000</rate>
            </mode>
          </monitor>
        </logicalmonitor>
        <logicalmonitor>
          <x>0</x>
          <y>0</y>
          <scale>1</scale>
          <primary>yes</primary>
          <monitor>
            <monitorspec>
              <connector>DP-1</connector>
              <vendor>AUS</vendor>
              <product>ROG PG27U</product>
              <serial>#ASO02hiI6a7d</serial>
            </monitorspec>
            <mode>
              <width>3840</width>
              <height>2160</height>
              <rate>59.997</rate>
            </mode>
          </monitor>
        </logicalmonitor>
      </configuration>
    </monitors>
  '';
in {
  systemd.tmpfiles.rules = [
    "d /media/The_Store 0770 moxie users -"
    "w /sys/power/image_size - - - 160000000000"
    "L+ /var/lib/gdm/.config/monitors.xml - - - - ${monitors}"
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
