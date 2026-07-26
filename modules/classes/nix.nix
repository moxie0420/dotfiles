{
  lib,
  classes,
  den,
  ...
}: {
  classes.nix = {
    aspect-chain,
    class,
  }:
    den.batteries.forward {
      adaptArgs = lib.id;

      each = [
        "nixos"
        "homeManager"
      ];

      fromAspect = _: lib.head aspect-chain;
      fromClass = _: "nix";
      intoClass = lib.id;

      intoPath = _: [
        "nix"
        "settings"
      ];
    };

  den.schema.default.includes = [classes.nix];
}
