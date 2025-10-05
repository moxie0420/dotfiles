{flakes}: {
  config,
  inputs,
  options,
  lib,
  lib',
  pkgs,
  ...
}: let
  cfg = config.moxie.overlay;

  onTopOfUserPkgs = flakes.self.overlays.default;

  onTopOfFlakeInputs = import ../../overlays/cache-friendly.nix {
    inherit lib' inputs;
    nixpkgsConfig = cfg.flakeNixpkgs.config;
  };

  configType =
    if (options ? "nixpkgs")
    then options.nixpkgs.config.type
    else lib.types.attrs;
in {
  options.moxie.overlay = with lib; {
    enable = mkOption {
      default = true;
      example = false;
      type = types.bool;
      description = ''
        Whether to add Moxie's overlay to system's pkgs.
      '';
    };
    onTopOf = mkOption {
      type = types.enum [
        "flake-nixpkgs"
        "user-pkgs"
      ];
      default = "flake-nixpkgs";
      example = "user-pkgs";
      description = ''
        Build packages based on Moxie's flake or the system's pkgs.
      '';
    };

    flakeNixpkgs.config = mkOption {
      default = pkgs.config;
      defaultText = literalExpression "pkgs.config";
      example = lib.literalExpression ''
        { allowBroken = true; allowUnfree = true; }
      '';
      type = configType;
      description = ''
        Matches `nixpkgs.config` from the configuration of the Nix Packages collection.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays =
      if cfg.onTopOf == "flake-nixpkgs"
      then [
        onTopOfFlakeInputs
      ]
      else [
        onTopOfUserPkgs
      ];
  };
}
