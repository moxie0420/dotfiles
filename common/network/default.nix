{
  networking = {
    nameservers = [
      "100.100.100.100"
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  services = {
    # DNS Resolver
    bind.enable = true;
    tailscale.enable = true;
  };
}
