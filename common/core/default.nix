{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./console.nix
    ./containers.nix
    ./security.nix
    ./systemd.nix
    ./users.nix
    ./networking.nix
    ../nix
  ];

  environment.systemPackages = with pkgs; [
    libnotify
    nautilus
    alejandra
    clipse
    fzf
    ripgrep
    fd
    curl
    unzip
    wget
    gnumake
  ];

  documentation.dev.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = lib.mkDefault "23.11";

  time.timeZone = lib.mkDefault "America/Chicago";
}
