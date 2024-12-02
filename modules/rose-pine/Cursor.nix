{
  config,
  inputs,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.rose-pine;
in {
  config = lib.mkIf cfg.cursor.enable {
    home = {
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        name = "rose-pine";
        package = self.packages.${pkgs.system}.rosePineCursor;
        size = 16;
      };
      sessionVariables = {
        XCURSOR_THEME = "rose-pine";
        XCURSOR_SIZE = "16";
        HYPRCURSOR_THEME = "rose-pine-hyprcursor";
      };

      packages = [
        inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
        self.packages.${pkgs.system}.rose-pine-cursor
      ];
    };
  };
}
