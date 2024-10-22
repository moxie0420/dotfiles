{
  self,
  inputs,
  ...
}: let
  specialArgs = {inherit inputs self;};

  desktop = [
    ./core
    ./core/boot.nix

    ./hardware/bluetooth.nix
    ./hardware/udisks.nix

    ./harden.nix

    ./polkit.nix

    ./programs

    ./services
    {
      home-manager = {
        users.moxie.imports = "${self}/home/profiles";
        extraSpecialArgs = specialArgs;
      };
    }
  ];

  laptop =
    desktop
    ++ [
      ./hardware/backlight.nix
    ];
in {
  inherit desktop laptop;
}
