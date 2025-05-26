{
  imports = [
    ./ananicy.nix
    ./avahi.nix
    ./display-manager.nix
    ./mpd.nix
    ./openrgb.nix
  ];

  services = {
    dbus.implementation = "broker";
    irqbalance.enable = true;
  };
}
