{
  networking = {
    nameservers = [
      "100.100.100.100"
      "1.1.1.1"
      "1.0.0.1"
    ];
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
      ];
      allowedUDPPorts = [
        68
        546
      ];
    };
  };

  services = {
    tailscale.enable = true;
    resolved = {
      enable = true;
      dnssec = "true";
      domains = ["~."];
      fallbackDns = ["1.1.1.1" "1.0.0.1"];
      dnsovertls = "true";
    };
  };
}
