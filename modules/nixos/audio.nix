{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.moxie.audio;
in {
  options.moxie.audio = {
    enable = mkEnableOption "Enable audio support via pipewire";
    mpd = {
      enable = mkEnableOption "Enable MPD & RMPC";
      musicDirectory = mkOption {
        default = "";
        description = "The path to your music library";
        type = types.str;
      };
      user = mkOption {
        default = "";
        description = "The user mpd runs as";
        type = types.str;
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        helvum
        playerctl
        pwvucontrol
      ];

      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        jack.enable = true;
      };
    })

    (mkIf cfg.mpd.enable {
      environment.systemPackages = [
        rmpc
      ];

      services = {
        mpd = {
          inherit (cfg.mpd) enable musicDirectory user;
          startWhenNeeded = true;

          extraConfig = ''
            audio_output {
              type "pipewire"
              name "pipewire output"
            }

            audio_output {
              type "fifo"
              name "cava_fifo"
              path "/tmp/cava_fifo"
              format "48000:24:2"
            }
          '';
        };

        mpdscribble = {
          inherit (cfg.mpd) enable;
          journalInterval = 90;
        };
      };

      systemd.services.mpd.environment = {
        XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${user}.uid}";
      };
    })
  ];
}
