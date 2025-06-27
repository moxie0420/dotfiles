{
  imports = [
    ./ananicy.nix
    ./avahi.nix
    ./display-manager.nix
    ./openrgb.nix
  ];

  services = {
    dbus.implementation = "broker";
    irqbalance.enable = true;
  };
}
