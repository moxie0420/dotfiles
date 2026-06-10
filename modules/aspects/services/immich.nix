{
  services.immich.nixos = {
    services = {
      immich = {
        enable = true;
        accelerationDevices = ["/dev/dri/renderD128"];
        host = "0.0.0.0";
      };

      immich-public-proxy = {
        enable = true;
        immichUrl = "http://127.0.0.1:2283";
        port = 6996;
      };
    };
    users.users.immich.extraGroups = ["video" "render"];
  };
}
