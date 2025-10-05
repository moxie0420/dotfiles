{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.moxie.displayManager;
in {
  options.moxie.displayManager = {
    enable = mkEnableOption "Enable my display manager config";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.dconf.profiles.gdm.databases = [
        {
          settings = {
            "org/gnome/mutter".experimental-features = ["variable-refresh-rate"];
          };
        }
      ];

      services.displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };

      systemd.tmpfiles.rules = [
        "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
          <monitors version="2">
            <configuration>
              <layoutmode>physical</layoutmode>
              <logicalmonitor>
                <x>0</x>
                <y>1080</y>
                <scale>1</scale>
                <primary>yes</primary>
                <monitor>
                  <monitorspec>
                    <connector>HDMI-2</connector>
                    <vendor>ACR</vendor>
                    <product>CB272</product>
                    <serial>0x01706b81</serial>
                  </monitorspec>
                  <mode>
                    <width>1920</width>
                    <height>1080</height>
                    <rate>74.973</rate>
                  </mode>
                </monitor>
              </logicalmonitor>
              <logicalmonitor>
                <x>0</x>
                <y>0</y>
                <scale>1</scale>
                <monitor>
                  <monitorspec>
                    <connector>HDMI-1</connector>
                    <vendor>SAM</vendor>
                    <product>SyncMaster</product>
                    <serial>0x00000001</serial>
                  </monitorspec>
                  <mode>
                    <width>1920</width>
                    <height>1080</height>
                    <rate>60.000</rate>
                  </mode>
                </monitor>
              </logicalmonitor>
            </configuration>
          </monitors>
        ''}"
      ];
    })
  ];
}
