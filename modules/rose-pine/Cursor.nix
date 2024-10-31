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
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "rose-pine";
      package = self.packages.${pkgs.system}.rosePineCursor;
      size = 16;
    };
    home.sessionVariables.XCURSOR_THEME = "rose-pine";
    home.sessionVariables.XCURSOR_SIZE = "16";

    # Hyprcursor
    home.packages = [inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default self.packages.${pkgs.system}.rosePineCursor];
    home.sessionVariables.HYPRCURSOR_THEME = "rose-pine-hyprcursor";
  };
}
