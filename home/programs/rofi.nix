{
  config,
  lib,
  ...
}: let
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  programs.rofi = {
    enable = true;
    plugins = [];
    theme = lib.mkAfter {
      window = {
        border-radius = mkLiteral "16px";
        border = mkLiteral "2px";
        padding = mkLiteral "8px";
      };
    };
  };
}
