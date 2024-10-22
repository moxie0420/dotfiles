{...}: {
  systemd.services.NetworkManager-wait-online.enable = false;
  networking = {
    hostName = "nixOwO";
    enableIPv6 = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    firewall = {
      allowedTCPPorts = [
        6443
      ];
    };
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
