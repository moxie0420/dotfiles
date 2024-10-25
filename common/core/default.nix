{lib, ...}: {
  imports = [
    ./console.nix
    ./hyprland.nix
    ./security.nix
    ./users.nix
    ./nix-ld.nix
    ../nix
    ./polkit.nix
  ];

  documentation.dev.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = lib.mkDefault "23.11";

  time.timeZone = lib.mkDefault "America/Chicago";

  zramSwap = {
    enable = true;
    memoryPercent = 20;
  };
}
