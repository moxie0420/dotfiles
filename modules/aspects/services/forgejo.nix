{
  services,
  self,
  lib,
  ...
}: {
  services.forgejo = {
    containerized = {
      includes = [
        services.forgejo.adminSecret
      ];

      nixos = {config, ...}: {
        users.users.forgejo = {
          group = "forgejo";
          isSystemUser = true;
        };
        users.groups.forgejo = {};

        containers.forgejo = {
          autoStart = true;
          privateNetwork = true;
          bindMounts.${config.age.secrets.forgejo-admin-secret.path}.isReadOnly = true;
          hostAddress = "192.168.100.1";
          localAddress = "192.168.100.11";
          config = services.forgejo.nixos;
        };
      };
    };

    adminSecret.nixos = {
      age.secrets.forgejo-admin-secret = {
        file = "${self}/secrets/forgejo-admin-secret.age";
        owner = "forgejo";
      };
    };

    nixos = {config, ...}: let
      cfg = config.services.forgejo;
      srv = cfg.settings.server;
    in {
      networking.firewall.allowedTCPPorts = [22 3000];

      systemd.services.forgejo.preStart = let
        adminCmd = "${lib.getExe cfg.package} admin user";
        pwd =
          if config.boot.isContainer
          then "/run/agenix/forgejo-admin-secret"
          else config.age.secrets.forgejo-admin-secret.path;
        user = "configUser";
      in ''
        ${adminCmd} create --admin --email "root@localhost" --username ${user} --password "$(tr -d '\n' < ${pwd})" || true
        ## uncomment this line to change an admin user which was already created
        # ${adminCmd} change-password --username ${user} --password "$(tr -d '\n' < ${pwd})" || true
      '';

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

          service.DISABLE_REGISTRATION = true;
        };
      };
    };
  };
}
