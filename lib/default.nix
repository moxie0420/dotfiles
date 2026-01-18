{
  lib,
  moxieOverlay,
  self,
  ...
}: let
  inherit (lib.strings) concatStringsSep;

  options = import ./options.nix {inherit lib;};

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

  toLines = concatStringsSep "\n";
in {
  _description = "Functions that i use around my config and modules";

  inherit toLines;
  inherit (options) mkEnabledOption mkFollowsOption;

  # import other lib parts
  colorschemes = import ./colorschemes.nix;
  disks = import ./disks {inherit lib;};
  hyprland = import ./hyprland.nix {inherit lib toLines;};
  kernelConfigs = import ./kernel {inherit lib;};
  pipewire = import ./pipewire.nix {inherit lib;};

  # General functions

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

  mkLaptop = host: extra:
    mkSystem host [
      (self + "/common/lanzeboot.nix")
      extra
    ];
  mkDesktop = host: extra:
    mkSystem host [
      (self + "/common/lanzeboot.nix")
      extra
    ];

  recurseForDerivations = false;
}
