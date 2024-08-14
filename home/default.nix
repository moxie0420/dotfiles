{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./style.nix
    ./desktop
    ./applications
  ];

  home = {
    username = "moxie";
    homeDirectory = "/home/moxie";

    packages = with pkgs; [
      alejandra
      qbittorrent

      #gaming
      heroic
      r2modman
      lutris
      (prismlauncher.overrideAttrs {
        withWaylandGLFW = true;
      })

      pavucontrol
      cmatrix
      libreoffice-fresh
      reaper

      devenv

      unityhub
    ];

    stateVersion = "23.11";
  };

  programs = {
    home-manager = {
      enable = true;
    };
    feh.enable = true;

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        input-overlay
        obs-vkcapture
        obs-multi-rtmp
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
