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
    };
  };

  programs = {
    gnome-disks.enable = true;
    file-roller.enable = true;
  };
}
