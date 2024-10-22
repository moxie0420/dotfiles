{...}: {
  systemd.services.NetworkManager-wait-online.enable = false;
  networking = {
    hostName = "nixOwO";
    wireless.iwd = {
      enable = true;
      settings = {
        general = {
          EnableNetworkConfiguration = false;
        };
      };
    };
  };
}
