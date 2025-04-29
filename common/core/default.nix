{lib, ...}: {
  imports = [
    ./console.nix
    ./security.nix
    ./systemd.nix
    ./users.nix
    ./nix-ld.nix
    ../nix
  ];

  documentation.dev.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = lib.mkDefault "23.11";

  time.timeZone = lib.mkDefault "America/Chicago";
}
