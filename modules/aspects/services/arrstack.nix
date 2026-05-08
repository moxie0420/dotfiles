{den, ...}: {
  services.arrstack = {
    includes = [
      den.aspects.containers
    ];

    nixos = {
      users.groups.nixarr = {};

      services = {
        # indexer managers
        prowlarr = {
          enable = true;
          openFirewall = true;
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

        qui = {
          enable = false;
          openFirewall = true;
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
        "autopulse" = {
          image = "ghcr.io/dan-online/autopulse:latest-sqlite";
          ports = ["2875:2875"];
          volumes = [
            "/mnt/the_store/autopulse.yaml:/app/config.yaml"
            "autopulse:/app/data"
          ];
          environment.AUTOPULSE__APP__DATABASE_URL = "sqlite://data/autopulse.db";
        };

        "cleanuparr" = {
          image = "ghcr.io/cleanuparr/cleanuparr:latest";
          ports = ["11011:11011"];
          volumes = ["cleanuparr:/config"];
          environment = {
            PORT = "11011";
          };
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
      };
    };
  };
}
