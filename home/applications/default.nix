{...}: {
  imports = [
    ./thunderbird.nix
    ./pandoc.nix
    ./neovim.nix
    ./terminal.nix
    ./spotify.nix
    ./coding.nix
    ./firefox.nix
  ];
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}
