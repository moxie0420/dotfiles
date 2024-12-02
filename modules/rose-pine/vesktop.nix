{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.rose-pine;
  themepkg = self.packages.${pkgs.system}.rose-pine-vesktop;
in {
  config.xdg.configFile =
    lib.mkIf
    cfg.vesktop.enable {
      "vesktop/themes/rose-pine.theme.css".source = "${themepkg}/rose-pine.theme.css";
      "vesktop/themes/rose-pine-moon.theme.css".source = "${themepkg}/rose-pine-moon.theme.css";
    };
}
