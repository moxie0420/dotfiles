{
  imports = [
    ./dconf.nix
    ./fonts.nix
    ./gamemode.nix
    ./games.nix
    ./hyprland.nix
    ./home-manager.nix
    ./xdg.nix
  ];

  programs = {
    adb.enable = true;
    file-roller.enable = true;
    gnome-disks.enable = true;

    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };

    seahorse.enable = true;
    thefuck.enable = true;
  };
}
