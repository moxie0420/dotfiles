{lib, ...}: {
  networking = {
    hostName = "nixUwU";
    enableIPv6 = false;
    useDHCP = lib.mkDefault true;
    dhcpcd.extraConfig = "noarp";
    firewall = {
    };
  };
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
  };
}
