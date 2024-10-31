{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.rose-pine;
in {
  config = lib.mkIf cfg.spotify.enable {
    programs.spicetify.theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.ziro;
    programs.spicetify.colorScheme = "rose-pine";
  };
}
