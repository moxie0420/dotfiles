{den, ...}: {
  services.vaultwarden = {
    includes = [
      den.aspects.containers
    ];

    nixos.virtualisation.oci-containers.containers = {
      "vaultwarden" = {
        image = "vaultwarden/server:latest";
        environment = {
          DOMAIN = "https://vaultwarden.fell-opaleye.ts.net";
          SIGNUPS_ALLOWED = "true";
        };
        ports = ["8812:80"];
        volumes = ["/opt/vaultwarden/_data:/data"];
      };
    };
  };
}
