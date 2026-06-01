{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.flake-file.flakeModules.dendritic
    inputs.den.flakeModules.dendritic
  ];

  # other inputs may be defined at a module using them.
  flake-file.inputs = let
    followsNixpkgs = url: {
      inherit url;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  in {
    # flake wiring
    den.url = "github:vic/den";
    flake-file.url = "github:vic/flake-file";
    nixpkgs.url = lib.mkForce "github:NixOS/nixpkgs/nixos-unstable";

    # $HOME managers
    home-manager = followsNixpkgs "github:nix-community/home-manager";
    hjem = followsNixpkgs "github:feel-co/hjem";
    nix-maid.url = "github:viperML/nix-maid";

    # Extra hosts
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };
}
