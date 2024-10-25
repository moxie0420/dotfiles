{
  imports = [
    ./gpg-agent.nix
    ./hypridle.nix
    ./mako.nix
  ];

  services.flameshot.enable = true;
}
