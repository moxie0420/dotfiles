let
  desktop = [
    ./core
    ./core/boot.nix
    ./core/lanzeboot.nix

    ./hardware/bluetooth.nix
    ./hardware/fwupd.nix
    ./hardware/mesa.nix
    ./hardware/udisks.nix

    ./network
    ./network/avahi.nix

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
