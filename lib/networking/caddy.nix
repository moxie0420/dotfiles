{
  mkTsService = tsName: name: port: {
    forwardAuthCfg ? "",
    preProxyConfig ? "",
    proxyConfig ? null,
    withAuth ? false,
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

        header {
          X-Content-Type-Options nosniff
          X-Frame-Options SAMEORIGIN
          Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
        }

        reverse_proxy :${toString port} ${proxyConf}
      }
    '';
  };
}
