{inputs, ...}: {
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.theme = {
    nixos = {
      lib,
      pkgs,
      ...
    }: let
      # schema constants
      rose-pine = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

      # font constants
      mapleMono = {
        package = pkgs.maple-mono.NF-CN;
        name = "Maple Mono NF CN";
      };
    in {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      # Use nix-community/stylix
      stylix.enable = lib.mkForce true;

      # Use rose-pine as the global base16 scheme
      stylix.base16Scheme = rose-pine;

      # Use the rose pine cursor
      stylix.cursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 18;
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

      # Use mapleMono as the global font
      # Set font sizes in points for various software types
      stylix.fonts =
        lib.genAttrs ["serif" "sansSerif" "monospace"] (name: mapleMono)
        // {
          sizes.terminal = 10;
        };
    };
    homeManager = {
      stylix.targets.firefox = {
        colorTheme.enable = true;
        profileNames = ["default"];
      };
    };
  };
}
