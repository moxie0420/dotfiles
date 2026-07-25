{
  lib,
  den,
  inputs,
  ...
}: {
  den.aspects.stylix = {
    homeManager = {pkgs, ...}: {
      home.pointerCursor = {
        enable = true;
        package = lib.mkDefault pkgs.bibata-cursors;
        name = lib.mkDefault "Bibata-Modern-Classic";
        size = lib.mkDefault 18;
      };

      stylix.targets.firefox = {
        colorTheme.enable = true;
        profileNames = ["default"];
      };
    };
    includes = [
      den.aspects.theme
    ];
    nixos = {pkgs, ...}: let
      # font constants
      mapleMono = {
        package = pkgs.maple-mono.NF-CN;
        name = "Maple Mono NF CN";
      };
      # schema constants
      rose-pine = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    in {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];
      # Use rose-pine as the global base16 scheme
      stylix.base16Scheme = rose-pine;
      # Use the rose pine cursor
      stylix.cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 18;
      };
      # Use nix-community/stylix
      stylix.enable = lib.mkForce true;
      # Use mapleMono as the global font
      # Set font sizes in points for various software types
      stylix.fonts =
        lib.genAttrs ["serif" "sansSerif" "monospace"] (name: mapleMono)
        // {
          sizes.terminal = 10;
        };
      # # Use rose pine icons
      stylix.icons = rec {
        enable = true;
        package = pkgs.rose-pine-icon-theme;
        dark = "rose-pine-icons";
        light = dark;
      };
      # Set the opacity for various software types
      stylix.opacity = {
        popups = 0.8;
        terminal = 0.8;
      };
    };
    provides = {
      to-hosts.includes = [
        den.aspects.stylix
      ];
      to-users.includes = [
        den.aspects.stylix
      ];
    };
  };
  flake-file.inputs.stylix = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:nix-community/stylix";
  };
}
