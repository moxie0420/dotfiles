{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./programs
    ./services
    ./editorconfig.nix
    ./hyprland.nix
    ./theme.nix
    ./xdg.nix
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = config.home.pointerCursor.name;
      };
      "org/cinnamon/desktop/default-applications/terminal".exec = "kitty";
    };
  };
  gtk.enable = true;

  home = {
    username = "moxie";
    homeDirectory = "/home/moxie";

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };

    packages = with pkgs; let
      prismlauncher = pkgs.prismlauncher.override {
        jdks = with pkgs; [temurin-bin-21 temurin-bin-17 temurin-bin-8];
      };
      zen-browser = inputs.zen-browser.packages."${system}".default;
    in [
      alejandra
      cachix
      clipboard-jh
      gnome-firmware
      gnome-logs
      gnome-usage
      heroic
      hwinfo
      lutris
      nautilus
      prismlauncher
      qbittorrent-enhanced
      r2modman
      vesktop
      wineWowPackages.staging
      zen-browser
    ];

    stateVersion = "23.11";
  };
}
