{
  config,
  lib,
  ...
}: let
  inherit (lib) mkMerge mkIf;
  inherit (lib.options) mkOption;

  cfg = config.arrstack;
in {
  options.arrstack = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "controls whether the arrstack is enabled";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      services = {
        # *arrs
        bazarr = {
          enable = true;
          openFirewall = true;
        };

        flaresolverr = {
          enable = true;
          openFirewall = true;
        };

        lidarr = {
          enable = true;
          openFirewall = true;
        };

        prowlarr = {
          enable = true;
          openFirewall = true;
        };

        radarr = {
          enable = true;
          openFirewall = true;
        };

        readarr = {
          enable = true;
          openFirewall = true;
        };

        sonarr = {
          enable = true;
          openFirewall = true;
        };

        # qBittorrent for torrents
        qbittorrent = {
          enable = true;
          openFirewall = true;

          serverConfig = {
            LegalNotice.Accepted = true;
            Preferences = {
              WebUI = {
                Username = "moxie";
                Password_PBKDF2 = "91DPxCQcUJzYnYoqMQyx+g==:BbgChkK93kSOlBg4B2pMWaRa7Z4iOrj3ZfnmK6z6sj6zF0HXpnekDbEz9TsJGoRWWIHzFvN3SzLm/HTLc+/43w==";
              };
              General.Locale = "en";
            };
          };
        };

        jellyfin = {
          enable = true;
          openFirewall = true;
        };

        jellyseerr = {
          enable = true;
          openFirewall = true;
        };
      };
    })
  ];
}
