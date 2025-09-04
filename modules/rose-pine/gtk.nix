{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.rose-pine;
in {
  config = lib.mkIf cfg.gtk.enable {
    gtk = {
      iconTheme = {
        name = "rose-pine";
        package = pkgs.rose-pine-icon-theme;
      };
      theme = {
        name = "rose-pine";
        package = pkgs.rose-pine-gtk-theme;
      };
    };
  };
}
