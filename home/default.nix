{
  config,
  pkgs,
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
    in [
      alejandra
      bottles
      cachix
      clipboard-jh
      comma
      cyanrip
      ffmpeg
      gabutdm
      gimp
      gnome-firmware
      gnome-logs
      gnome-usage
      haruna # video player
      heroic
      hwinfo
      mplayer
      nautilus
      nvtopPackages.full
      picard
      prismlauncher
      pwvucontrol
      qbittorrent-enhanced
      r2modman
      shadps4
      wikiman
      wine64
    ];

    stateVersion = "23.11";
  };
}
