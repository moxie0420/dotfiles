{
  den,
  lib,
  ...
}: {
  classes.niri = {aspect-chain}:
    den.batteries.forward {
      each = lib.singleton true;
      fromClass = _: "niri";
      intoClass = _: "homeManager";
      intoPath = _: ["programs" "niri" "settings"];
      fromAspect = _: lib.head aspect-chain;
    };
}
