{
  imports = [
    ./display-manager.nix
  ];

  services = {
    dbus.implementation = "broker";
    irqbalance.enable = true;
  };
}
