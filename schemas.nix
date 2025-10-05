{
  inputs,
  flake-schemas ? inputs.flake-schemas,
}: {
  inherit
    (flake-schemas.schemas)
    devShells
    formatter
    homeModules
    legacyPackages
    nixosConfigurations
    nixosModules
    overlays
    packages
    schemas
    ;

  nixConfig = {
    version = 1;
    doc = ''
      Exposes nixConfig as seen in Flakes.
    '';
    inventory = _output: {
      shortDescription = "Exposes nixConfig as seen in Flakes.";
      what = "attrset";
    };
  };

  homeManagerModules = flake-schemas.schemas.homeModules;

  lib' = {
    version = 1;
    doc = ''
      All of my custom functions used throughout this flake
    '';
    inventory = output: {
      children = builtins.mapAttrs (_name: _value: {
        what = "function";
      }) (builtins.removeAttrs output ["_description"]);
    };
  };
}
