{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./desktop
    ./applications
  ];
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
    ];

    stateVersion = "23.11";
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    home-manager.enable = true;
    feh.enable = true;

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        input-overlay
        obs-vkcapture
        obs-rgb-levels-filter
        obs-gradient-source
      ];
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableExtraSocket = true;
      sshKeys = [
        "C02F30F9FD65E05531A321C8491E3EFE1C0C7383"
      ];
    };
  };
}
