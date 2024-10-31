{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.rose-pine;
in {
  config.xdg.configFile = lib.mkIf cfg.kitty.enable {
    "kitty/themes/".source = "${self.packages.${pkgs.system}.rosePineKitty}/themes";
    "kitty/icons/".source = "${self.packages.${pkgs.system}.rosePineKitty}/icons";
  };
  config.programs.kitty.extraConfig = lib.mkIf cfg.kitty.enable "include rose-pine.conf";
}
