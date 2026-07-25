{
  den,
  programs,
  self,
  ...
}: {
  den.aspects.theme = {
    homeManager = {
      config,
      lib,
      pkgs,
      ...
    }: let
      cfg = config.theme;
    in {
      options.theme = {
        image = lib.mkOption {
          default = "${self}/wallpapers/station.gif";
          description = "image used as a wallpape, can be any format supported by awww";
          example = "\"\${self}/wallpapers/witchy.gif\"";
          type = lib.types.nullOr lib.types.str;
        };
      };

      config = {
        gtk = {
          enable = true;
          colorScheme = "dark";
          gtk4.theme = config.gtk.theme;
          iconTheme = {
            package = pkgs.rose-pine-icon-theme;
            name = "oomox-rose-pine";
          };
          theme = {
            package = pkgs.rose-pine-gtk-theme;
            name = "oomox-rose-pine";
          };
        };

        home.pointerCursor = {
          enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
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
