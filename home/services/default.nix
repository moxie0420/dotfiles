{
  imports = [
    ./gpg-agent.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./mako.nix
  ];

  services.flameshot.enable = true;
}
