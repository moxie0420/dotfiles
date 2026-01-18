{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.moxie.displayManager;
in {
  options.moxie.displayManager = {
    enable = mkEnableOption "Enable my display manager config";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.dconf.profiles.gdm.databases = [
        {
          settings = {
            "org/gnome/mutter".experimental-features = ["variable-refresh-rate"];
          };
        }
      ];

      services.displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
    })
  ];
}
