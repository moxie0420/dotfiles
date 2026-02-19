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
        };

        # media server & requesters
        jellyfin = {
          enable = true;
          openFirewall = true;
        };

        jellyseerr = {
          enable = true;
          openFirewall = true;
        };

        ombi = {
          enable = true;
          openFirewall = true;
        };
      };

      virtualisation.oci-containers.containers = {
        "homarr" = {
          image = "ghcr.io/homarr-labs/homarr:latest";
          ports = ["7575:7575"];
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "homarr-data:/appdata"
          ];
          environmentFiles = [
            config.age.secrets.homarr.path
          ];
        };
      };
    })
  ];
}
