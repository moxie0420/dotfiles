{
  imports = [
    ./fonts.nix
    ./gamemode.nix
    ./games.nix
    ./home-manager.nix
    ./xdg.nix
  ];

  programs = {
    # make HM-managed GTK stuff work
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      };
    };
  };

  services.xserver.displayManager.gdm.enable = true;
}
