{
  den,
  lib,
  ...
}: {
  classes.nix = {
    class,
    aspect-chain,
  }:
    den.batteries.forward {
      each = ["nixos" "homeManager"];
      fromClass = _: "nix";
      intoClass = lib.id;
      intoPath = _: ["nix" "settings"];
      fromAspect = _: lib.head aspect-chain;
      adaptArgs = lib.id;
    };
}
