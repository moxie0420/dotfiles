{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./theme.nix
    ./hyprland.nix
    ./programs
    ./services
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

    packages = with pkgs; [
      alejandra
      cachix
      clipboard-jh
      heroic
      hwinfo
      lutris
      (pkgs.prismlauncher.override {
        jdks = with pkgs; [temurin-bin-21 temurin-bin-17 temurin-bin-8];
      })
      qbittorrent-enhanced
      r2modman

      wineWowPackages.staging

      jetbrains.idea-ultimate
      inputs.zen-browser.packages."${system}".default
      vesktop
      nautilus
    ];

    stateVersion = "23.11";
  };
}
