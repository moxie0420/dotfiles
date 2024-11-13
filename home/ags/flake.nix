{
  description = "a basic devshell using flake-parts";

  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-parts.url = "github:hercules-ci/flake-parts";
    mkdocs-flake.url = "github:applicative-systems/mkdocs-flake";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devshell.flakeModule
        inputs.mkdocs-flake.flakeModule
      ];

      systems = ["x86_64-linux"];

      perSystem = {pkgs, ...}: {
        devshells.default = {
          name = "generic devshell";
          motd = ''
            Welcome to you dev flake\n
            Checkout ./flake.nix to get started
          '';
          env = [];
          commands = [];
          packages = with pkgs; [
            nodejs_latest
          ];
        };

        documentation.mkdocs-root = ./docs;
      };
    };
}
