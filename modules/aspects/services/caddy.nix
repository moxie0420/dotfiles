{
  lib,
  self,
  services,
  ...
}: {
  services.caddy = {config, ...}: {
    imports = [
      {
        options = {
          tsName = lib.mkOption {
            type = lib.types.str;
          };
        };
      }
    ];

    tsName = "fell-opaleye";

    containerized = {
      includes = [
        services.caddy.secret
      ];

      nixos = {config, ...}: {
        boot.kernel.sysctl = {
          "net.core.rmem_max" = 7500000;
          "net.core.wmem_max" = 7500000;
        };

        containers.caddy = {
          autoStart = true;

          bindMounts.caddy-env = {
            isReadOnly = true;
            hostPath = config.age.secrets.tailscale-auth-env.path;
            mountPoint = "/caddy-env";
          };

          config = {
            imports = [
              services.caddy.nixos
            ];

            system.stateVersion = "26.11";
          };

          extraFlags = [
            "--drop-capability=CAP_SYS_CHROOT"
            "--drop-capability=CAP_SYS_ADMIN"
            "--property=CPUQuota=100%"
          ];
        };

        services.tailscale.permitCertUid = "caddy";
      };
    };

    secret.nixos = {
      age.secrets.caddy-env.file = "${self}/secrets/tailscale-auth-env.age";
    };

    nixos = {
      config,
      lib,
      pkgs,
      ...
    }: let
      inherit (config.boot) isContainer;

      forwardAuth = ''
        reverse_proxy /outpost.goauthentik.io/* https://sso.moxiege.com {
          header_up Host {http.reverse_proxy.upstream.host}
        }

        forward_auth https://sso.moxiege.com {
          uri /outpost.goauthentik.io/auth/caddy
           copy_headers X-Authentik-Username X-Authentik-Groups X-Authentik-Entitlements X-Authentik-Email X-Authentik-Name X-Authentik-Uid X-Authentik-Jwt X-Authentik-Meta-Jwks X-Authentik-Meta-Outpost X-Authentik-Meta-Provider X-Authentik-Meta-App X-Authentik-Meta-Version
           trusted_proxies private_ranges
        }
      '';

      mkTsService = name: port: {
        withAuth ? false,
        forwardAuthCfg ? forwardAuth,
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
        "https://${name}.${services.caddy.tsName}.ts.net".extraConfig = ''
          bind tailscale/${name}

          tls {
            get_certificate tailscale
          }

          route {
            encode br gzip zstd
            ${forwardAuthVal}
            ${preProxyConfig}

            header {
              X-Content-Type-Options nosniff
              X-Frame-Options SAMEORIGIN
              Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
            }

            reverse_proxy :${toString port} ${proxyConf}
          }
        '';
      };
    in {
      boot.kernel.sysctl = {
        "net.core.rmem_max" = 7500000;
        "net.core.wmem_max" = 7500000;
      };

      networking.firewall = {
        allowedTCPPorts = [80 443];
        allowedUDPPorts = [443];
      };

      services.caddy = {
        enable = true;

        environmentFile =
          if isContainer
          then "/caddy-env"
          else config.age.secrets.caddy-env.path;

        package = pkgs.caddy.withPlugins {
          plugins = [
            "github.com/ueffel/caddy-brotli@v1.6.0"
            "github.com/caddy-dns/cloudflare@v0.2.4"
            "github.com/tailscale/caddy-tailscale@v0.0.0-20260106222316-bb080c4414ac"
            "github.com/mholt/caddy-l4@v0.1.1"
          ];
          hash = "sha256-pREDASeg+BzOgHJzoeEKhx8wXW2+cqU3iMphwPGwxNc=";
        };

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
          (lib.mkBefore {
            "http://".extraConfig = ''
              redir https://{host}{uri} permanent
            '';
          })

          (mkTsService "immich" 2283 {})

          (mkTsService "jellyfin" 8096 {})

          (mkTsService "jellyseer" 5055 {})

          # the *arr stack
          (mkTsService "bazarr" 6767 {})
          (mkTsService "lidarr" 8686 {})
          (mkTsService "prowlarr" 9696 {})
          (mkTsService "radarr" 7878 {})
          (mkTsService "readarr" 8787 {})
          (mkTsService "sonarr" 8989 {})
          (mkTsService "torrent" 8080 {})

          (mkTsService "vaultwarden" 8812 {
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

      services.tailscale.permitCertUid = "caddy";
    };
  };
}
