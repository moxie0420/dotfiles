{
  den,
  programs,
  self,
  ...
}: {
  den.aspects.theme = {
    homeManager = {
      lib,
      config,
      pkgs,
      ...
    }: let
      cfg = config.theme;
    in {
      config = {
        gtk = {
          colorScheme = "dark";
          enable = true;
          gtk4.theme = config.gtk.theme;

          iconTheme = {
            name = "oomox-rose-pine";
            package = pkgs.rose-pine-icon-theme;
          };

          theme = {
            name = "oomox-rose-pine";
            package = pkgs.rose-pine-gtk-theme;
          };
        };

        home.pointerCursor = {
          enable = true;
          name = "Bibata-Modern-Classic";
          package = pkgs.bibata-cursors;
          size = 12;
        };

        programs.niri.settings.spawn-at-startup = [
          (lib.mkIf (lib.isString cfg.image) {
            argv = [
              "awww"
              "img"
              cfg.image
              "--transition-type"
              "random"
            ];
          })
        ];
      };

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
    };

    provides.to-users.includes = [
      den.aspects.theme
      programs.awww
    ];
  };
}
