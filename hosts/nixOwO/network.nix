{
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
