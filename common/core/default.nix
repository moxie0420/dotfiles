{lib, ...}: {
  imports = [
    ./security.nix
    ./users.nix
    ./nix-ld.nix
    ../nix
  ];

  documentation.dev.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = lib.mkDefault "23.05";

  time.timeZone = lib.mkDefault "America/Chicago";

  zramSwap.enable = true;
}
