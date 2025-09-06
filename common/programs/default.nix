{
  imports = [
    ./dconf.nix
    ./fish.nix
    ./fonts.nix
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
      terminal = "wezterm";
    };

    seahorse.enable = true;
    pay-respects.enable = true;
  };
}
