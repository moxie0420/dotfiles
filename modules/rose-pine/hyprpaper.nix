{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.rose-pine;
  rose-wallpaper = "${self.packages.${pkgs.system}.rosePineWallpapers}/share/wallpapers/${cfg.hyprpaper.variant}.png";
in {
  options.rose-pine.hyprpaper.variant = lib.mkOption {
    type = lib.types.enum [
      "ascii"
      "asciidawn"
      "bay"
      "blockwavedawn"
      "blockwavemoon"
      "clouds"
      "field"
      "flower"
      "leafy-dawn"
      "leafy-moon"
      "leafy"
      "moon"
      "oceandrone1"
      "oceandrone2"
      "pointoverhead"
      "rocks"
      "rose_pine_circle"
      "rose_pine_circle2"
      "rose_pine_contourline"
      "rose_pine_maze"
      "rose_pine_noiseline"
      "rose_pine_shape"
      "roses"
      "seals"
      "seaslug"
      "something-beautiful-in-nature-mobile"
      "something-beautiful-in-nature"
    ];
    default = "bay";
  };

  config = lib.mkIf cfg.hyprpaper.enable {
    services.hyprpaper.settings = lib.mkDefault {
      preload = [rose-wallpaper];

      wallpaper = [
        ",${rose-wallpaper}"
      ];
    };
  };
}
