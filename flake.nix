# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "Madelyn's personal flake for her home environment, desktop, and laptop";
  inputs = {
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    agenix.url = "github:ryantm/agenix";
    authentik-nix.url = "github:nix-community/authentik-nix";
    catppuccin.url = "github:catppuccin/nix";
    cthulock.url = "github:FriederHannenheim/cthulock";
    den.url = "github:vic/den";
    deploy-rs.url = "github:serokell/deploy-rs";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    direnv-instant.url = "github:Mic92/direnv-instant";
    disko.url = "github:nix-community/disko/latest";
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
      url = "github:hercules-ci/flake-parts";
    };
    home-manager.url = "github:nix-community/home-manager";
    import-tree.url = "github:vic/import-tree";
    niri-nix.url = "git+https://codeberg.org/BANanaD3V/niri-nix";
    nix-auto-follow = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:fzakaria/nix-auto-follow";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nix-gaming-edge.url = "github:powerofthe69/nix-gaming-edge";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixcord.url = "github:FlameFlag/nixcord";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-lib.follows = "nixpkgs";
    pedantix.url = "github:swarsel/pedantix";
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
    stasis.url = "github:saltnpepper97/stasis";
    stylix.url = "github:nix-community/stylix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
