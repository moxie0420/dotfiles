{
  imports = [
    ./gpg-agent.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./mako.nix
    ./pipewireIdleInhibit.nix
  ];

  services.flameshot.enable = true;
}
