{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./desktop
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
      WLR_NO_HARDWARE_CURSORS = 0;
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      XCURSOR_THEME = "rose-pine";
      XCURSOR_SIZE = 24;
    };

    packages = with pkgs; [
      alejandra
      qbittorrent

      #gaming
      heroic
      r2modman
      lutris
      (pkgs.prismlauncher.override {
        jdks = with pkgs; [temurin-bin-21 temurin-bin-17 temurin-bin-8];
      })

      pavucontrol
      libreoffice-fresh

      devenv
      unityhub

      jetbrains.idea-ultimate
      inputs.zen-browser.packages."${system}".default
      vesktop
      nautilus
    ];

    stateVersion = "23.11";
  };
}
