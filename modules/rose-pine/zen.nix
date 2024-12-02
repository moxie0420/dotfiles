{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.rose-pine;
  themepkg = self.packages.${pkgs.system}.rose-pine-zen;
in {
  config = lib.mkIf cfg.zen.enable {
    # zen
    home.file.".zen/8combnke.Default Profile/chrome/userChrome.css".source = "${themepkg}/userChrome.css";
    home.file.".zen/8combnke.Default Profile/chrome/rose-pine-main.css".source = "${themepkg}/rose-pine-main.css";
  };
}
