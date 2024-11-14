{
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
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
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
      lutris
      (pkgs.prismlauncher.override {
        jdks = with pkgs; [temurin-bin-21 temurin-bin-17 temurin-bin-8];
      })
      qbittorrent-enhanced
      r2modman

      jetbrains.idea-ultimate
      inputs.zen-browser.packages."${system}".default
      vesktop
      nautilus
      nixd
    ];

    stateVersion = "23.11";
  };
}
