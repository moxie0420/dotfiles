{
  imports = [
    ./ananicy.nix
    ./avahi.nix
    ./display-manager.nix
    ./openrgb.nix
    ./sshd.nix
  ];

  services = {
    dbus.implementation = "broker";
    irqbalance.enable = true;
  };
}
