{
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
        route {
          encode br gzip zstd
          ${forwardAuthVal}
          ${preProxyConfig}
          reverse_proxy :${toString port} ${proxyConf}
        }
      '';
    };
  in {
    services.caddy = {
      enable = true;
      environmentFile = config.age.secrets.tailscale-auth-env.path;
      package = pkgs.caddy.withPlugins {
        plugins = [
          "github.com/ueffel/caddy-brotli@v1.6.0"
          "github.com/tailscale/caddy-tailscale@v0.0.0-20260106222316-bb080c4414ac"
        ];
        hash = "sha256-fsvVuJIt3AOogGtp7FBZS9JoycGI/fNleDxTujyBIOU=";
      };

      virtualHosts = lib.mkMerge [
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

        # authentik
        (mkTsService "auth" 9000 {
          preProxyConfig = ''
            reverse_proxy /outpost.goauthentik.io/* http://100.74.48.73:9000 {
              header_up Host {http.reverse_proxy.upstream.hostport}
            }
          '';
        })

        {
          "https://sso.moxiege.com".extraConfig = ''
            # tls {
            #   dns cloudflare {env.CF_API_TOKEN}
            # }
            route {
              encode br gzip zstd
              reverse_proxy /outpost.goauthentik.io/* http://100.74.48.73:9000 {
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
