{
  config,
  lib,
  ...
}: let
  cfg = config.rose-pine;
in {
  config = lib.mkIf cfg.mako.enable {
    services.mako = {
      backgroundColor = "#26233a";
      borderColor = "#ebbcba";
      borderRadius = 20;
      borderSize = 1;
      textColor = "#e0def4";
    };
  };
}
