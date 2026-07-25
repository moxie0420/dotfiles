{lib, ...}: {
  services.caddy.nixUwU = {
    nixos = {lib', ...}: let
      inherit (lib'.networking.caddy) mkTsService;

      # forwardAuth = ''
      #   reverse_proxy /outpost.goauthentik.io/* https://sso.moxiege.com {
      #     header_up Host {http.reverse_proxy.upstream.host}
      #   }

      #   forward_auth https://sso.moxiege.com {
      #     uri /outpost.goauthentik.io/auth/caddy
      #      copy_headers X-Authentik-Username X-Authentik-Groups X-Authentik-Entitlements X-Authentik-Email X-Authentik-Name X-Authentik-Uid X-Authentik-Jwt X-Authentik-Meta-Jwks X-Authentik-Meta-Outpost X-Authentik-Meta-Provider X-Authentik-Meta-App X-Authentik-Meta-Version
      #      trusted_proxies private_ranges
      #   }
      # '';

      tsName = "fell-opaleye";
    in {
      services.caddy = {
        globalConfig = ''
          servers {
            listener_wrappers {
              layer4 {
                @ssh ssh
                route @ssh {
                  proxy 192.168.100.11:22
                }
                route
              }

              tls {
                dns cloudflare {env.CF_API_TOKEN}
                protocols tls1.3 tls1.2
                ciphers ECDHE-RSA-WITH-AES-256-GCM-SHA384
              }
            }
          }
        '';

        virtualHosts = lib.mkMerge [
          (mkTsService tsName "immich" 2283 {})

          (mkTsService tsName "jellyfin" 8096 {})

          (mkTsService tsName "jellyseer" 5055 {})

          # the *arr stack
          (mkTsService tsName "bazarr" 6767 {})
          (mkTsService tsName "lidarr" 8686 {})
          (mkTsService tsName "prowlarr" 9696 {})
          (mkTsService tsName "radarr" 7878 {})
          (mkTsService tsName "readarr" 8787 {})
          (mkTsService tsName "sonarr" 8989 {})
          (mkTsService tsName "torrent" 8080 {})

          (mkTsService tsName "vaultwarden" 8812 {
            proxyConfig = ''
              header_up X-Real-IP {remote_host}
            '';
          })

          # authentik
          {
            "https://sso.moxiege.com".extraConfig = ''
              encode br gzip zstd

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
          }

          # immich public proxy
          {
            "https://shared.moxiege.com".extraConfig = ''
              request_body {
               	max_size 10MB
              }

              header {
                X-Content-Type-Options nosniff
                X-Frame-Options SAMEORIGIN
                Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
              }

              encode br gzip zstd
              reverse_proxy :6996
            '';
          }

          {
            "https://git.moxiege.com".extraConfig = ''
              request_body {
              	max_size 10MB
              }

              header {
                X-Content-Type-Options nosniff
                X-Frame-Options SAMEORIGIN
                Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
              }

              encode br gzip zstd
              reverse_proxy 192.168.100.11:3000
            '';
          }
        ];
      };
    };
  };
}
