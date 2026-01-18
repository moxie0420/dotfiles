{
  system.stateVersion = "26.05";
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}
