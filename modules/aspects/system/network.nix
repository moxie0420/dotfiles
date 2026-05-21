{
  den.quirks.firewall = {
    description = "Firewall port declarations";
  };

  system.network = {
    nixos = {
      config,
      lib,
      options,
      firewall,
      ...
    }: let
      inherit (options.networking) timeServers;
    in {
      boot = {
        kernelModules = ["tcp_bbr"];
        kernel.sysctl = {
          ## TCP optimization
          # TCP Fast Open is a TCP extension that reduces network latency by packing
          # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
          # both incoming and outgoing connections:
          "net.ipv4.tcp_fastopen" = 3;
          # Bufferbloat mitigations + slight improvement in throughput & latency
          "net.ipv4.tcp_congestion_control" = "bbr";
          "net.core.default_qdisc" = "cake";
        };
      };

      networking = {
        firewall = {
          enable = true;

          # Allow PMTU/DHCP
          allowPing = true;

          allowedTCPPorts = lib.concatMap (f: f.ports.tcp or []) firewall;
          allowedUDPPorts = lib.flatten [
            (lib.concatMap (f: f.ports.udp or []) firewall)
            config.services.tailscale.port
          ];

          # Allow the Tailscale UDP port through the firewall
          logRefusedConnections = lib.mkDefault false;

          # Always allow traffic from my Tailscale network
          trustedInterfaces = ["tailscale0"];
        };

        # use cloudflare's 1.1.1.1 dns
        nameservers = [
          "1.1.1.1#one.one.one.one"
          "1.0.0.1#one.one.one.one"
        ];

        # use nftables as my firewall
        nftables.enable = true;

        # add cloudflare's time server to the ntp pool
        timeServers =
          timeServers.default
          ++ [
            "time.cloudflare.com"
          ];

        # ensure iwd is enabled for wifi
        # used as the backend for networkmanager
        wireless.iwd.enable = true;
      };

      services.tailscale.enable = true;

      services.resolved = {
        enable = true;
        dnssec = true;
        domains = ["~."];
        fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
        dnsovertls = true;
      };

      systemd = {
        network.wait-online.enable = true;
        services.NetworkManager-wait-online.enable = false;
        services.tailscaled.serviceConfig.Environment = ["TS_DEBUG_FIREWALL_MODE=nftables"];
      };
    };
  };
}
