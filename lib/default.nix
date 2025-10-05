{
  lib,
  moxieOverlay,
  self,
  ...
}: let
  base = [
    (self + "/common")
  ];

  mkSystem = host: extra:
    lib.lists.flatten
    [
      base
      host
      extra
    ];
in {
  _description = "Functions that i use around my config and modules";

  kernelConfigs = import ./kernel {inherit lib;};

  applyOverlay = {
    replace ? false,
    merge ? false,
    overlay ? moxieOverlay,
    moxiePkgs ? null,
    onlyDerivations ? false,
    pkgs,
  }: let
    fullPackages =
      if replace
      then pkgs // ourPackages
      else ourPackages // pkgs;
    overlayFinal =
      fullPackages
      // {
        callPackage = pkgs.newScope overlayFinal;
      };
    ourPackages =
      if moxiePkgs != null
      then moxiePkgs
      else overlay overlayFinal pkgs;
    preFilter =
      if merge
      then overlayFinal
      else ourPackages;
  in
    if onlyDerivations
    then
      pkgs.lib.attrsets.filterAttrs (
        _k: v: (builtins.tryEval v).success && pkgs.lib.attrsets.isDerivation v
      )
      preFilter
    else preFilter;

  mkDesktop = mkSystem;

  mkLaptop = host: extra:
    mkSystem host [
      (self + "/common/lanzeboot.nix")
      extra
    ];

  recurseForDerivations = false;
}
