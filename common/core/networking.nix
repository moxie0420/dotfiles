{
  services.resolved.enable = true;
  networking = {
    networkmanager.enable = true;
    wireless.iwd = {
      enable = true;
    };
  };
}
