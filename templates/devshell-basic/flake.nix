{
  description = "a basic devshell using flake-parts";

  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-parts.url = "github:hercules-ci/flake-parts";
    mkdocs-flake.url = "github:applicative-systems/mkdocs-flake";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    ...
  }: {
    imports = [
      inputs.devshell.flakeModule
      inputs.mkdocs-flake.flakeModule
    ];
    perSystem = {pkgs, ...}: {
      systems = ["x86_64-linux"];

      devshell.default = {
        name = "generic devshell";
        motd = ''
          Welcome to you dev flake\n
          Checkout ./flake.nix to get started
        '';
        env = [];
        commands = [];
        packages = [];
      };

      documentation.mkdocs-root = ./docs;
    };
  };
}
