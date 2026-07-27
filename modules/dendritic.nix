{
  lib,
  inputs,
  self,
  withSystem,
  ...
}: {
  debug = true;
  flake.lib = import "${self}/lib" {inherit lib;};

  flake-file = {
    description = "Madelyn's personal flake for her home environment, desktop, and laptop";

    inputs = {
      den.url = "github:vic/den";
      flake-file.url = "github:vic/flake-file";

      flake-parts = {
        inputs.nixpkgs-lib.follows = "nixpkgs-lib";
        url = "github:hercules-ci/flake-parts";
      };

      home-manager = {
        inputs.nixpkgs.follows = "nixpkgs";
        url = "github:nix-community/home-manager";
      };

      import-tree.url = "github:vic/import-tree";
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      nixpkgs-lib.follows = "nixpkgs";

      pedantix = {
        inputs = {
          flake-parts.follows = "flake-parts";
          nixpkgs.follows = "nixpkgs";
        };

        url = "github:swarsel/pedantix";
      };

      pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";

      treefmt-nix = {
        inputs.nixpkgs.follows = "nixpkgs";
        url = "github:numtide/treefmt-nix";
      };
    };

    write-hooks = [
      {
        program = pkgs:
          pkgs.writeShellApplication {
            name = "format-hook";

            text = ''
              nix fmt
            '';
          };
      }
    ];
  };

  imports = with inputs; [
    treefmt-nix.flakeModule
    pedantix.flakeModules.default
    flake-file.flakeModules.dendritic
    den.flakeModules.dendritic
    pkgs-by-name-for-flake-parts.flakeModule
  ];

  perSystem = {
    pkgsDirectory = ../pkgs;
    pkgsNameSeparator = "-";
  };
}
