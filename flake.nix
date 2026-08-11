# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "Madelyn's personal flake for her home environment, desktop, and laptop";
  inputs = {
    agenix = {
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:ryantm/agenix";
    };
    authentik-nix.url = "github:nix-community/authentik-nix";
    catppuccin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:catppuccin/nix";
    };
    cthulock = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:FriederHannenheim/cthulock";
    };
    den.url = "github:vic/den";
    deploy-rs = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:serokell/deploy-rs";
    };
    determinate.url = "github:DeterminateSystems/determinate";
    direnv-instant = {
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:Mic92/direnv-instant";
    };
    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko/latest";
    };
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
    niri-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+https://codeberg.org/BANanaD3V/niri-nix";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nix-gaming-edge = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:powerofthe69/nix-gaming-edge";
    };
    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-index-database";
    };
    nixcord = {
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-nixcord.follows = "nixpkgs";
      };
      url = "github:FlameFlag/nixcord";
    };
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
    stasis = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:saltnpepper97/stasis";
    };
    stylix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/stylix";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix";
    };
  };
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
