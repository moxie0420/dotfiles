{
  den,
  self,
  ...
}: {
  services.arrstack = {
    includes = [
      den.aspects.containers
      den.aspects.secrets
    ];

    nixos = {
      age.secrets = {
        qbittorrent.file = "${self}/secrets/qbittorrent.age";
        homarr.file = "${self}/secrets/homarr.age";
        sonarr-key = {
          file = "${self}/secrets/sonarr-key.age";
          group = "nixarr";
        };
        radarr-key = {
          file = "${self}/secrets/radarr-key.age";
          group = "nixarr";
        };
      };

      users.groups.nixarr = {};

      services = {
        # indexer managers
        prowlarr = {
          enable = true;
          openFirewall = true;
          group = "nixarr";
        };
        # *arrs
        bazarr = {
          enable = true;
          openFirewall = true;
          group = "nixarr";
        };

        flaresolverr = {
          enable = true;
          openFirewall = true;
        };

        lidarr = {
          enable = true;
          openFirewall = true;
          group = "nixarr";
        };

        radarr = {
          enable = true;
          openFirewall = true;
          group = "nixarr";
        };

        readarr = {
          enable = true;
          openFirewall = true;
          group = "nixarr";
        };

        sonarr = {
          enable = true;
          openFirewall = true;
          group = "nixarr";
        };

        # qBittorrent for torrents
        qbittorrent = {
          enable = true;
          openFirewall = true;
          group = "nixarr";
        };

        # media server & requesters
        jellyfin = {
          enable = true;
          openFirewall = true;
          group = "nixarr";
        };

        seerr = {
          enable = true;
          openFirewall = true;
        };
      };

      virtualisation.oci-containers.containers = {
        "cleanuparr" = {
          image = "ghcr.io/cleanuparr/cleanuparr:latest";
          ports = ["11011:11011"];
          volumes = ["/opt/cleanuparr:/config"];
          environment.PORT = "11011";
        };

        "slskd" = {
          image = "slskd/slskd";
          ports = [
            "5030:5030"
            "50300:50300"
          ];
          environment = {
            SLSKD_REMOTE_CONFIGURATION = "true";
            SLSKD_SHARED_DIR = "/music;/books";
          };
          volumes = [
            "/mnt/the_store/soulseekd:/app"
            "/mnt/the_store/downloads:/app/downloads"
            "/mnt/the_store/music:/music"
            "/mnt/the_store/books:/books"
          ];
        };

        "soularr" = {
          image = "mrusse08/soularr:latest";
          ports = [
            "8265:8265"
          ];

          environment = {
            TZ = "CST/UTC";
            SCRIPT_INTERVAL = "300";
          };
          volumes = [
            "/mnt/the_store/downloads:/downloads"
            "/opt/soularr:/data"
          ];
        };
      };
    };
  };
}
