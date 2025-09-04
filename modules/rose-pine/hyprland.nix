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
    };
  };
}
