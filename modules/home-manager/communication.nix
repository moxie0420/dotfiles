{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.moxie.communication;
in {
  options.moxie.communication = {
    enable = mkOption {
      default = config.moxie.enable;
      example = false;
      type = types.bool;
      description = ''
        Enable various communication programs and configure them
      '';
    };

    sync = mkOption {
      default = cfg.enable;
      example = false;
      type = types.bool;
      description = ''
        Enable Nextcloud filesync client
      '';
    };

    vesktop = mkOption {
      default = cfg.enable;
      example = false;
      type = types.bool;
      description = ''
        Enable Vesktop and a simple config
      '';
    };
  };

  config = mkMerge [
    (mkIf cfg.sync {
      services = {
        kdeconnect = {
          enable = true;
          indicator = true;
        };
        nextcloud-client = {
          enable = false;
          startInBackground = true;
        };
      };
    })

    {
      programs.vesktop.enable = cfg.vesktop;
    }
  ];
}
