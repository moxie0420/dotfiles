{
  imports = [
    ./ananicy.nix
    ./avahi.nix
    ./display-manager.nix
    ./openrgb.nix
    ./upower.nix
  ];

  services = {
    dbus.implementation = "broker";
    flatpak.enable = true;
    irqbalance.enable = true;
  };
}
