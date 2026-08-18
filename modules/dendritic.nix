{
  lib,
  inputs,
  self,
  ...
}: {
  debug = true;
  flake.lib = import "${self}/lib" {inherit lib;};

  flake-file = {
    description = "Madelyn's personal flake for her home environment, desktop, and laptop";
    formatter = pkgs: inputs.pedantix.packages.${pkgs.stdenv.hostPlatform.system}.pedantix-wrapped;

    inputs = {
      den.url = "github:vic/den";
      flake-file.url = "github:vic/flake-file";

      flake-parts = {
        inputs.nixpkgs-lib.follows = "nixpkgs-lib";
        url = "github:hercules-ci/flake-parts";
      };

      home-manager = {
        url = "github:nix-community/home-manager";
      };

      import-tree.url = "github:vic/import-tree";
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      nixpkgs-lib.follows = "nixpkgs";

      pedantix = {
        url = "github:swarsel/pedantix";
      };

      pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";

      treefmt-nix = {
        url = "github:numtide/treefmt-nix";
      };
    };
  };

  imports = with inputs; [
    (den.flakeModule or {})
    (den.flakeModules.dendritic or {})
    (flake-file.flakeModules.dendritic or {})
    (flake-file.flakeModules.nix-auto-follow or {})
    (pedantix.flakeModules.default or {})
    (pkgs-by-name-for-flake-parts.flakeModule or {})
    (treefmt-nix.flakeModule or {})
  ];

  perSystem = {
    pkgsDirectory = ../pkgs;
    pkgsNameSeparator = "-";
  };
}
