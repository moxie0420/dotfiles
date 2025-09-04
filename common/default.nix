let
  desktop = [
    ./core
    ./core/boot.nix

    ./hardware
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
      ./core/lanzeboot.nix
      ./hardware/backlight.nix
    ];
in {
  inherit desktop laptop;
}
