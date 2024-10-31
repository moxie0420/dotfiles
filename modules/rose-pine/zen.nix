{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.rose-pine;
in {
  config = lib.mkIf cfg.zen.enable {
    # zen
    home.file.".zen/8combnke.Default Profile/chrome/userChrome.css".source = "${self.packages.${pkgs.system}.rosePineZen}/userChrome.css";
    home.file.".zen/8combnke.Default Profile/chrome/rose-pine-main.css".source = "${self.packages.${pkgs.system}.rosePineZen}/rose-pine-main.css";
  };
}
