{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.moxie.shell;
in {
  options.moxie.shell = {
    enable = mkEnableOption "Enable Eza and other shell tools";
    gpu = mkOption {
      type = types.enum ["amd" "nvidia" ""];
      default = "";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.btop = {
        enable = true;
        package = mkDefault pkgs.btop;
        settings.theme_background = false;
      };
    })

    (mkIf (cfg.gpu == "amd") {
      programs.btop.package = pkgs.btop-rocm;
    })

    (mkIf (cfg.gpu == "nvidia") {
      programs.btop.package = pkgs.btop-cuda;
    })
  ];
}
