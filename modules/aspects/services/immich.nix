{
  services.immich.nixos = {
    services.immich = {
      enable = true;
      accelerationDevices = ["/dev/dri/renderD128"];
      host = "0.0.0.0";
      openFirewall = true;
    };
    users.users.immich.extraGroups = ["video" "render"];
  };
}
