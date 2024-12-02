{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.rose-pine;
in {
  config = lib.mkIf cfg.wofi.enable {
    programs.wofi.settings.stylesheet = "${self.packages.${pkgs.system}.rose-pine-wofi}/rosepine/style.css";
  };
}
