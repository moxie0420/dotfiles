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
    wayland.windowManager.hyprland.settings.source = ["${self.packages.${pkgs.system}.rosePineHyprland}/rose-pine.conf"];
    wayland.windowManager.hyprland.settings.general."col.active_border" = "$rose";
    wayland.windowManager.hyprland.settings.general."col.inactive_border" = "$muted";
  };
}
