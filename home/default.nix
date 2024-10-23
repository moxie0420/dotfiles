{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./programs
    ./services
    ./theme.nix
    ./xdg.nix
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/cinnamon/desktop/default-applications/terminal".exec = "kitty";
    };
  };

  home = {
    username = "moxie";
    homeDirectory = "/home/moxie";

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      XCURSOR_THEME = "rose-pine";
      XCURSOR_SIZE = 24;
    };

    packages = with pkgs; [
      alejandra
      clipboard-jh
      heroic
      lutris
      (pkgs.prismlauncher.override {
        jdks = with pkgs; [temurin-bin-21 temurin-bin-17 temurin-bin-8];
      })
      r2modman

      jetbrains.idea-ultimate
      inputs.zen-browser.packages."${system}".default
      vesktop
      nautilus
    ];

    stateVersion = "23.11";
  };
}
