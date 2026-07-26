{
  lib,
  inputs,
  self,
  ...
}: {
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.pedantix.flakeModules.default
    inputs.flake-file.flakeModules.dendritic
    inputs.den.flakeModules.dendritic
  ];

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

      treefmt-nix = {
        inputs.nixpkgs.follows = "nixpkgs";
        url = "github:numtide/treefmt-nix";
      };
    };

    outputs = ''
      inputs:
      inputs.flake-parts.lib.mkFlake { inherit inputs; } {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
        imports = [
          (inputs.import-tree ./modules)
        ];
      }
    '';
  };
}
