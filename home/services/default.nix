{
  imports = [
    ./easyeffects.nix
    ./gpg-agent.nix
    ./hypridle.nix
    ./mpd.nix
    ./udiskie.nix
  ];

  services.swww.enable = true;
}
