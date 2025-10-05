{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.moxie.audio;
in {
  options.moxie.audio = {
    enable = mkEnableOption "Enable Easyeffects, Cava and other similar music software";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.cava = {
        enable = true;
        settings = {
          general.framerate = 30;
          input.method = "pipewire";
          smoothing = {
            noise_reduction = 88;
            monstercat = 1;
          };
        };
      };

      services.easyeffects.enable = true;
    })
  ];
}
