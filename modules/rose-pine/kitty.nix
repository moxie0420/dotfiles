{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.rose-pine;
  themepkg = self.packages.${pkgs.system}.rose-pine-kitty;
in {
  config.xdg.configFile = lib.mkIf cfg.kitty.enable {
    "kitty/themes/".source = "${themepkg}/themes";
    "kitty/icons/".source = "${themepkg}/icons";
  };
  config.programs.kitty.extraConfig = lib.mkIf cfg.kitty.enable "include rose-pine.conf";
}
