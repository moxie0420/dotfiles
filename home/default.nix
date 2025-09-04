{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./editorconfig.nix
    ./fonts.nix
    ./gtk.nix
    ./hyprland
    ./programs
    ./scripts
    ./services
    ./xdg.nix
    inputs.zen-browser.homeModules.twilight
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/cinnamon/desktop/default-applications/terminal".exec = "wezterm";
    };
  };

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
    };
  };

  home = {
    username = "moxie";
    homeDirectory = "/home/moxie";
    shell.enableShellIntegration = true;

    pointerCursor = {
      enable = true;
      package = pkgs.rose-pine-gtk-theme;
      name = "rose-pine";
      size = 16;
    };

    packages = with pkgs; let
      rose-pine-hyprcursor = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
      prismlauncher = pkgs.prismlauncher.override {
        jdks = [temurin-bin-21 temurin-bin-17 temurin-bin-8];
      };
    in [
      baobab
      cyanrip
      heroic
      hwinfo
      olympus
      osu-lazer-bin
      prismlauncher
      qbittorrent-enhanced
      rose-pine-hyprcursor
      r2modman
    ];

    stateVersion = "23.11";
  };
}
