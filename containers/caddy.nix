{
  system.stateVersion = "26.05";

  services.caddy = {
    enable = true;
    virtualHosts = {
      "https://nixuwu.tail83fd33.ts.net".extraConfig = ''
        encode zstd gzip

        handle /vault/* {
          reverse_proxy localhost:8812 {
            header_up X-Real-IP {remote_host}
          }
        }

        handle /admin/* {
          reverse_proxy localhost:8080 {
            transport http {
              tls_insecure_skip_verify
            }
          }
        }

        handle /* {
          reverse_proxy localhost:11000
        }
      '';

      "https://nixuwu.tail83fd33.ts.net:3000".extraConfig = ''
        reverse_proxy localhost:8096
      '';

      "http://localhost:9000".extraConfig = ''
        handle ^/_matrix/client/(api/v1|r0|v3|unstable)/voip/turnServer$ {
          reverse_proxy localhost:4499
        }

        handle /* {
          reverse_proxy localhost:8008
        }
      '';
    };
  };
}
