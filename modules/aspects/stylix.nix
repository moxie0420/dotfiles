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
        name = lib.mkDefault "Bibata-Modern-Classic";
        package = lib.mkDefault pkgs.bibata-cursors;
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
        name = "Maple Mono NF CN";
        package = pkgs.maple-mono.NF-CN;
      };
      # schema constants
      rose-pine = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    in {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      stylix = {
        # Use rose-pine as the global base16 scheme
        base16Scheme = rose-pine;

        # Use the rose pine cursor
        cursor = {
          name = "Bibata-Modern-Classic";
          package = pkgs.bibata-cursors;
          size = 18;
        };

        # Use nix-community/stylix
        enable = lib.mkForce true;

        # Use mapleMono as the global font
        # Set font sizes in points for various software types
        fonts =
          lib.genAttrs ["serif" "sansSerif" "monospace"] (name: mapleMono)
          // {
            sizes.terminal = 10;
          };

        # # Use rose pine icons
        icons = rec {
          dark = "rose-pine-icons";
          enable = true;
          light = dark;
          package = pkgs.rose-pine-icon-theme;
        };

        # Set the opacity for various software types
        opacity = {
          popups = 0.8;
          terminal = 0.8;
        };
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
    url = "github:nix-community/stylix";
  };
}
