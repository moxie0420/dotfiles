{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.moxie.audio;
  discord = config.moxie.communication.vesktop;
in {
  options.moxie.audio = {
    enable = mkEnableOption "Enable Easyeffects, Cava and other similar music software";
    mpd = {
      enable = mkOption {
        default = cfg.enable;
        example = false;
        type = types.bool;
        description = ''
          Enable user mpd config and discord rich presence
        '';
      };
    };
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

      services.playerctld.enable = true;
    })

    (mkIf cfg.mpd.enable {
      services.mpd-discord-rpc.enable = discord;
    })
  ];
}
