{services, ...}: {
  services.forgejo = {
    containerized = {
      nixos = {
        containers.forgejo = {
          autoStart = true;
          privateNetwork = true;
          hostAddress = "192.168.100.1";
          localAddress = "192.168.100.11";
          config = services.forgejo.nixos;
        };
      };
    };

    nixos = {config, ...}: let
      cfg = config.services.forgejo;
      srv = cfg.settings.server;
    in {
      network.firewall.allowedTCPPorts = [22 3000];

      services.forgejo = {
        enable = true;
        database.type = "postgres";
        lfs.enable = true;

        settings = {
          server = {
            DOMAIN = "git.moxiege.com";
            # You need to specify this to remove the port from URLs in the web UI.
            ROOT_URL = "https://${srv.DOMAIN}/";
            HTTP_PORT = 3000;
            SSH_PORT = 22;
          };

          service.DISABLE_REGISTRATION = false;
        };
      };
    };
  };
}
