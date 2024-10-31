{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.rose-pine;
in {
  config.xdg.configFile =
    lib.mkIf
    cfg.vesktop.enable {
      "vesktop/themes/rose-pine.theme.css".source = "${self.packages.${pkgs.system}.rosePineVesktop}/rose-pine.theme.css";
      "vesktop/themes/rose-pine-moon.theme.css".source = "${self.packages.${pkgs.system}.rosePineVesktop}/rose-pine-moon.theme.css";
    };
}
