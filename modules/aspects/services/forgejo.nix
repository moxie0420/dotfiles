{
  lib,
  den,
  inputs,
  self,
  services,
  ...
}: {
  services.forgejo = {
    adminSecret.nixos = {
      age.secrets.forgejo-admin-secret = {
        file = "${self}/secrets/forgejo-admin-secret.age";
        owner = "forgejo";
      };

      users = {
        groups.forgejo = {};

        users.forgejo = {
          group = "forgejo";
          isSystemUser = true;
        };
      };
    };

    containerized = {
      includes = [
        services.forgejo.adminSecret
      ];

      nixos = {
        containers.forgejo = {
          config = {
            imports = [
              inputs.agenix.nixosModules.default
              services.forgejo.nixos
              services.forgejo.adminSecret.nixos
            ];

            age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"];
            # Use systemd-resolved inside the container
            # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
            networking.useHostResolvConf = lib.mkForce false;
            services.resolved.enable = true;
            system.stateVersion = "26.11";
          };

          autoStart = true;
          bindMounts."/etc/ssh/ssh_host_ed25519_key".isReadOnly = true;

          extraFlags = [
            "--drop-capability=CAP_SYS_CHROOT"
            "--property=CPUQuota=100%"
          ];

          hostAddress = "192.168.100.1";
          localAddress = "192.168.100.11";
          privateNetwork = true;
        };
      };
    };

    includes = [
      den.aspects.secrets
    ];

    nixos = {config, ...}: let
      cfg = config.services.forgejo;
      srv = cfg.settings.server;
    in {
      networking.firewall.allowedTCPPorts = [
        22
        3000
      ];

      services.forgejo = {
        enable = true;
        database.type = "postgres";
        lfs.enable = true;

        settings = {
          server = {
            DOMAIN = "git.moxiege.com";
            HTTP_PORT = 3000;
            # You need to specify this to remove the port from URLs in the web UI.
            ROOT_URL = "https://${srv.DOMAIN}/";
            SSH_PORT = 22;
          };

          service.DISABLE_REGISTRATION = true;
        };
      };

      systemd.services.forgejo.preStart = let
        adminCmd = "${lib.getExe cfg.package} admin user";
        pwd = config.age.secrets.forgejo-admin-secret.path;
        user = "configUser";
      in ''
        ${adminCmd} create --admin --email "root@localhost" --username ${user} --password "$(tr -d '\n' < ${pwd})" || true
        ## uncomment this line to change an admin user which was already created
        ${adminCmd} change-password --username ${user} --password "$(tr -d '\n' < ${pwd})" || true
      '';
    };
  };
}
