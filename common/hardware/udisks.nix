{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse
  ];
  services = {
    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
    udisks2 = {
      enable = true;
      mountOnMedia = true;
      settings = {
        "udisks2.conf" = {
          defaults = {
            encryption = "luks2";
          };
          udisks2 = {
            modules = [
              "*"
            ];
            modules_load_preference = "ondemand";
          };
        };
      };
    };
  };
}
