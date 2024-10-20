{lib, ...}: {
  services.bind.enable = true;
  networking = {
    hostName = "nixUwU";
    enableIPv6 = false;
    useDHCP = lib.mkDefault true;
    dhcpcd.extraConfig = "noarp";
    firewall = {
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    defaultGateway = {
      address = "172.31.11.1";
      interface = "eno2";
    };
    interfaces.eno2 = {
      ipv4.addresses = [
        {
          address = "172.31.11.103";
          prefixLength = 24;
        }
      ];
    };
  };
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
  };
}
