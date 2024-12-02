{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.rose-pine;
in {
  config = lib.mkIf cfg.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      source = ["${self.packages.${pkgs.system}.rose-pine-hyprland}/rose-pine.conf"];
      general = {
        "col.active_border" = "$rose";
        "col.inactive_border" = "$muted";
      };
    };
  };
}
