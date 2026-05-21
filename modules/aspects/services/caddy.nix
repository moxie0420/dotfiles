{self, ...}: {
  services.caddy.nixos = {
    config,
    lib,
    pkgs,
    ...
  }: let
    tsName = "fell-opaleye";

    mkTsService = name: port: {
      withAuth ? false,
      forwardAuthCfg ? ''
        reverse_proxy /outpost.goauthentik.io/* https://sso.moxiege.com {
          header_up Host {http.reverse_proxy.upstream.host}
        }

        forward_auth https://sso.moxiege.com {
          uri /outpost.goauthentik.io/auth/caddy
           copy_headers X-Authentik-Username X-Authentik-Groups X-Authentik-Entitlements X-Authentik-Email X-Authentik-Name X-Authentik-Uid X-Authentik-Jwt X-Authentik-Meta-Jwks X-Authentik-Meta-Outpost X-Authentik-Meta-Provider X-Authentik-Meta-App X-Authentik-Meta-Version
           trusted_proxies private_ranges
        }
      '',
      preProxyConfig ? "",
      proxyConfig ? null,
    }: let
      forwardAuthVal =
        if withAuth
        then forwardAuthCfg
        else "";

      proxyConf =
        if proxyConfig != null
        then " {\n${proxyConfig}\n}"
        else "";
    in {
      "https://${name}.${tsName}.ts.net".extraConfig = ''
        bind tailscale/${name}

        tls {
          get_certificate tailscale
        }

        route {
          encode br gzip zstd
          ${forwardAuthVal}
          ${preProxyConfig}
          reverse_proxy :${toString port} ${proxyConf}
        }
      '';
    };
  in {
    age.secrets.tailscale-auth-env.file = "${self}/secrets/tailscale-auth-env.age";

    boot.kernel.sysctl = {
      "net.core.rmem_max" = 7500000;
      "net.core.wmem_max" = 7500000;
    };

    networking.firewall.allowedTCPPorts = [443];

    services.caddy = {
      enable = true;
      environmentFile = config.age.secrets.tailscale-auth-env.path;
      package = pkgs.caddy.withPlugins {
        plugins = [
          "github.com/ueffel/caddy-brotli@v1.6.0"
          "github.com/caddy-dns/cloudflare@v0.2.4"
          "github.com/tailscale/caddy-tailscale@v0.0.0-20260106222316-bb080c4414ac"
        ];
        hash = "sha256-+bKVVStk6DgtFH163KIKUV5qrn358AJrZhcQACgW/PM=";
      };

      virtualHosts = lib.mkMerge [
        (mkTsService "immich" 2283 {})

        (mkTsService "jellyfin" 8096 {})
        (mkTsService "jellyseer" 5055 {})

        # the *arr stack
        (mkTsService "bazarr" 6767 {
          })
        (mkTsService "lidarr" 8686 {
          })
        (mkTsService "prowlarr" 9696 {
          })
        (mkTsService "radarr" 7878 {
          })
        (mkTsService "readarr" 8787 {
          })
        (mkTsService "sonarr" 8989 {
          })
        (mkTsService "torrent" 8080 {
          })

        # authentik
        {
          "https://sso.moxiege.com".extraConfig = ''
            tls {
              dns cloudflare {env.CF_API_TOKEN}
            }
            route {
              encode br gzip zstd
              reverse_proxy /outpost.goauthentik.io/* :9000 {
                header_up Host {http.reverse_proxy.upstream.hostport}
              }
              reverse_proxy :9000
            }
          '';
        }

        # vaultwarden
        (mkTsService "vaultwarden" 8812 {
          proxyConfig = ''
            header_up X-Real-IP {remote_host}
          '';
        })
      ];
    };

    services.tailscale.permitCertUid = "caddy";
  };
}
