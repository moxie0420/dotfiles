{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.rose-pine.qbittorrent;
  themepkg = self.packages.${pkgs.system}.rose-pine-qbittorrent;
in {
  config = lib.mkIf cfg.enable {
    home.file."Themes/qbittorrent".source = themepkg;
  };
}
