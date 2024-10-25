{
  imports = [
    ./fonts.nix
    ./gamemode.nix
    ./games.nix
    ./hyprland.nix
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
    file-roller.enable = true;
    gnome-disks.enable = true;
    seahorse.enable = true;
  };
}
