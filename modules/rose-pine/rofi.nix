{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.rose-pine;
in {
  config = lib.mkIf cfg.rofi.enable {
    programs.rofi.theme = "${self.packages.${pkgs.system}.rose-pine-rofi}/rose-pine.rasi";
  };
}
