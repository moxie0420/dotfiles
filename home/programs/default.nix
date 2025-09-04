{...}: {
  imports = [
    ./ashell.nix
    ./beets.nix
    ./btop.nix
    ./cava.nix
    ./comma.nix
    ./discord.nix
    ./direnv.nix
    ./eza.nix
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./hyfetch.nix
    ./hyprlock.nix
    ./lutris.nix
    ./mangohud.nix
    ./obs-studio.nix
    ./pandoc.nix
    ./rofi.nix
    ./starship.nix
    ./tealdeer.nix
    ./wezterm.nix
  ];

  programs.lazydocker.enable = true;
}
