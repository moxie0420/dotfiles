{
  config,
  lib,
  self,
  ...
}:
with lib; let
  cfg = config.rose-pine;
in {
  options.rose-pine = {
    enable = mkEnableOption "enable rose-pine for all detected programs";
    vesktop.enable = mkEnableOption "enable rose-pine for vesktop";
    vesktop.package = mkOption {
      type = with types; package;
      default = self.packages.rosePineVesktop;
    };
  };

  config =
    mkIf
    (cfg.enable || cfg.vesktop.enable) {
      xdg.dataFile."vesktop/themes/rose-pine.theme.css".source = "${self.packages.rosePineVesktop}/rose-pine.theme.css";
      xdg.dataFile."vesktop/themes/rose-pine-moon.theme.css".source = "${self.packages.rosePineVesktop}/rose-pine-moon.theme.css";
    };
}
