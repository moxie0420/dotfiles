{
  desktop.keyring.nixos = {
    # enable seahorse for gnome-keyring management
    programs.seahorse.enable = true;
    # enable gnome-keyring
    services.gnome.gnome-keyring.enable = true;
  };
}
