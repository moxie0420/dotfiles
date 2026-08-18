{
  den,
  inputs,
  programs,
  self,
  ...
}: {
  den.aspects.theme = {
    homeManager = {
      lib,
      config,
      ...
    }: let
      cfg = config.theme;
    in {
      config = {
        catppuccin = let
          accent = "pink";
        in {
          inherit accent;
          autoEnable = true;

          cursors = {
            inherit accent;
            enable = true;
          };

          enable = true;
        };

        gtk = {
          colorScheme = "dark";
          enable = true;
          gtk4.theme = config.gtk.theme;
        };

        home.pointerCursor = {
          enable = true;
          size = 12;
        };

        # programs.niri.settings.spawn-at-startup = [
        #   (lib.mkIf (lib.isString cfg.image) {
        #     argv = [
        #       "awww"
        #       "img"
        #       cfg.image
        #       "--transition-type"
        #       "random"
        #     ];
        #   })
        # ];
      };

      imports = [
        inputs.catppuccin.homeModules.catppuccin
      ];

      options.theme = {
        image = lib.mkOption {
          default = "${self}/wallpapers/station.gif";
          description = "image used as a wallpape, can be any format supported by awww";
          example = "\"\${self}/wallpapers/witchy.gif\"";
          type = lib.types.nullOr lib.types.str;
        };
      };
    };

    nixos = {pkgs, ...}: {
      catppuccin = let
        accent = "pink";
      in {
        inherit accent;
        autoEnable = true;

        cursors = {
          inherit accent;
          enable = true;
        };

        enable = true;
      };

      fonts = {
        enableDefaultPackages = true;

        fontconfig.defaultFonts = {
          monospace = [
            "Maple Mono NF CN"
            "Noto Color Emoji"
          ];

          sansSerif = [
            "Maple Mono NF CN"
            "Noto Color Emoji"
          ];

          serif = ["Maple Mono NF CN"];
        };

        packages = [
          pkgs.maple-mono.NF-CN
        ];
      };

      imports = [
        inputs.catppuccin.nixosModules.catppuccin
      ];
    };

    provides.to-users.includes = [
      den.aspects.theme
      programs.awww
    ];
  };

  flake-file.inputs.catppuccin.url = "github:catppuccin/nix";
}
