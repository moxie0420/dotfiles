{
  services.caddy.theHub = {
    nixos = {
      services.caddy = {
        globalConfig = ''
          pki {
            ca internal {
              name Benavides_CA
            }
          }
          skip_install_trust
        '';

        virtualHosts = {
          # services
          "auth.theHub.lan".extraConfig = ''
            tls internal

            request_body {
              max_size 10MB
            }

            header {
              X-Content-Type-Options nosniff
              X-Frame-Options SAMEORIGIN
              Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
            }

            reverse_proxy /outpost.goauthentik.io/* :9000 {
              header_up Host {http.reverse_proxy.upstream.hostport}
            }

            reverse_proxy :9000
          '';

          "immich.lan".extraConfig = ''
            tls internal
            reverse_proxy :2283
          '';

          # machines
          "theHub.lan".extraConfig = ''
            tls internal
            respond "hello there :3"
          '';
        };
      };
    };
  };
}
