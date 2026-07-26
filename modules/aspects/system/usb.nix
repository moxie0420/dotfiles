{
  system.usb.nixos = {pkgs, ...}: {
    environment.systemPackages = builtins.attrValues {
      inherit
        (pkgs)
        ifuse
        libimobiledevice
        ;
    };

    services = {
      gvfs.enable = true;

      udisks2 = {
        enable = true;
        mountOnMedia = true;

        settings."udisks2.conf" = {
          defaults.encryption = "luks2";

          udisks2 = {
            modules = ["*"];
            modules_load_preference = "ondemand";
          };
        };
      };

      usbmuxd = {
        enable = true;
        package = pkgs.usbmuxd2;
      };
    };
  };
}
