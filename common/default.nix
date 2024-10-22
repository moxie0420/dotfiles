let
  desktop = [
    ./core
    ./core/boot.nix
    ./core/lanzeboot.nix

    ./hardware/bluetooth.nix
    ./hardware/fwupd.nix
    ./hardware/graphics.nix
    ./hardware/udisks.nix

    ./network
    ./network/avahi.nix

    ./polkit.nix

    ./programs

    ./services
    ./services/gnome-services.nix
    ./services/pipewire.nix
  ];

  laptop =
    desktop
    ++ [
      ./hardware/backlight.nix
    ];
in {
  inherit desktop laptop;
}
