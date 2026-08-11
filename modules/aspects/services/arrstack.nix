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
        homarr.file = "${self}/secrets/homarr.age";
        qbittorrent.file = "${self}/secrets/qbittorrent.age";

        radarr-key = {
          file = "${self}/secrets/radarr-key.age";
          group = "nixarr";
        };

        sonarr-key = {
          file = "${self}/secrets/sonarr-key.age";
          group = "nixarr";
        };
      };

      services = {
        # *arrs
        bazarr = {
          enable = true;
          group = "nixarr";
          openFirewall = true;
        };

        flaresolverr = {
          enable = true;
          openFirewall = true;
        };

        # media server & requesters
        jellyfin = {
          enable = true;
          group = "nixarr";
          openFirewall = true;
        };

        lidarr = {
          enable = true;
          group = "nixarr";
          openFirewall = true;
        };

        # indexer managers
        prowlarr = {
          enable = true;
          openFirewall = true;
        };

        # qBittorrent for torrents
        qbittorrent = {
          enable = true;
          group = "nixarr";
          openFirewall = true;
        };

        radarr = {
          enable = true;
          group = "nixarr";
          openFirewall = true;
        };

        readarr = {
          enable = true;
          group = "nixarr";
          openFirewall = true;
        };

        seerr = {
          enable = true;
          openFirewall = true;
        };

        sonarr = {
          enable = true;
          group = "nixarr";
          openFirewall = true;
        };
      };

      users.groups.nixarr = {};

      virtualisation.oci-containers.containers = {
        "cleanuparr" = {
          environment.PORT = "11011";
          image = "ghcr.io/cleanuparr/cleanuparr:latest";
          ports = ["11011:11011"];
          volumes = ["/opt/cleanuparr:/config"];
        };

        # "slskd" = {
        #   environment = {
        #     SLSKD_REMOTE_CONFIGURATION = "true";
        #     SLSKD_SHARED_DIR = "/music;/books";
        #   };

        #   image = "slskd/slskd";

        #   ports = [
        #     "5030:5030"
        #     "50300:50300"
        #   ];

        #   volumes = [
        #     "/mnt/the_store/soulseekd:/app"
        #     "/mnt/the_store/downloads:/app/downloads"
        #     "/mnt/the_store/music:/music"
        #     "/mnt/the_store/books:/books"
        #   ];
        # };

        # "soularr" = {
        #   environment = {
        #     SCRIPT_INTERVAL = "300";
        #     TZ = "CST/UTC";
        #   };

        #   image = "mrusse08/soularr:latest";

        #   ports = [
        #     "8265:8265"
        #   ];

        #   volumes = [
        #     "/mnt/the_store/downloads:/downloads"
        #     "/opt/soularr:/data"
        #   ];
        # };
      };
    };
  };
}
