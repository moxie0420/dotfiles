{
  description = "a basic devshell using flake-parts";

  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    ...
  }: {
    imports = [
      inputs.devshell.flakeModule
    ];
    perSystem = {pkgs, ...}: {
      devshell.default = {
        env = [];
        commands = [];
        packages = [];
      };
    };
  };
}
