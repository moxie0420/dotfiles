{
  lib,
  inputs,
  ...
}: {
  den.aspects.determinate = with inputs.determinate; {
    homeManager = {
      imports = [
        homeManagerModules.default
      ];

      nix.package = lib.mkForce null;
    };

    nixos.imports = [
      nixosModules.default
    ];
  };

  flake-file.inputs.determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
}
