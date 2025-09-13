let
  base = [
    ./core
    ./hardware/bluetooth.nix
    ./hardware/general.nix
    ./hardware/graphics.nix

    ./network
    ./network/avahi.nix

    ./programs/dconf.nix
    ./programs/fish.nix
    ./programs/fonts.nix
    ./programs/general.nix
    ./programs/home-manager.nix
    ./programs/hyprland.nix
    ./programs/steam.nix
    ./programs/wine.nix
    ./programs/xdg.nix

    ./services/ananicy.nix
    ./services/avahi.nix
    ./services/dbus.nix
    ./services/display-manager.nix
    ./services/gnome-services.nix
    ./services/openrgb.nix
    ./services/udisks.nix
  ];

  desktop = base;

  laptop =
    base
    ++ [
      ./core/lanzeboot.nix
      ./services/autocpufreq.nix
      ./services/upower.nix
      ./programs/brightnessctl.nix
    ];
in {
  inherit desktop laptop;
}
