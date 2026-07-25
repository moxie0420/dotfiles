{
  system.network.dns = {
    nixos = {
      networking.nameservers = [
        "1.1.1.1"
        "1.0.0.1"
      ];
    };
  };
}
