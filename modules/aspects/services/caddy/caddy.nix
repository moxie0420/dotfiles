{self, ...}: {
  services.caddy = {
    firewall = {
      tcpPorts = [
        80
        443
      ];

      udpPorts = [443];
    };

    http-backends = {host, ...}: {
      inherit (host) address;
      port = host.httpPort;
    };

    nixos = {pkgs, ...}: {
      boot.kernel.sysctl = {
        "net.core.rmem_max" = 7500000;
        "net.core.wmem_max" = 7500000;
      };

      services = {
        caddy = {
          enable = true;

          package = pkgs.caddy.withPlugins {
            hash = "sha256-Y9+TXOsd8ku+2zUDooF6XHNZBQxkVxSQcI9ORfeKqag=";

            plugins = [
              "github.com/ueffel/caddy-brotli@v1.6.0"
              "github.com/caddy-dns/cloudflare@v0.2.4"
              "github.com/tailscale/caddy-tailscale@v0.0.0-20260106222316-bb080c4414ac"
              "github.com/mholt/caddy-l4@v0.1.1"
            ];
          };
        };

        tailscale.permitCertUid = "caddy";
      };
    };

    secret.nixos = {config, ...}: {
      age.secrets.caddy-ts-env.file = "${self}/secrets/tailscale-auth-env.age";
      services.caddy.environmentFile = config.age.secrets.caddy-ts-env.path;
    };
  };
}
