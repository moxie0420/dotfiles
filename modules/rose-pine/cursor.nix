{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.rose-pine;
in {
  config = lib.mkIf cfg.cursor.enable {
    home = {
      pointerCursor = {
        gtk.enable = true;
        package = pkgs.rose-pine-gtk-theme;
        name = "rose-pine";
        size = 16;
      };
      sessionVariables = {
        HYPRCURSOR_THEME = "rose-pine-hyprcursor";
      };

      packages = [
        inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
        #self.packages.${pkgs.system}.rose-pine-cursor
      ];
    };
  };
}
