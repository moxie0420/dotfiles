{system, ...}: {
  system.network = {
    includes = [
      system.network.dns
      system.network.optimizations
    ];

    nixos = {
      lib,
      firewall ? {},
      ...
    }: {
      networking = {
        firewall = {
          allowedTCPPorts = lib.concatMap (f: f.tcpPorts or []) firewall;
          allowedUDPPorts = lib.concatMap (f: f.udpPorts or []) firewall;
          # Allow the Tailscale UDP port through the firewall
          logRefusedConnections = lib.mkDefault false;
        };

        # add cloudflare's time server to the ntp pool
        timeServers = ["time.cloudflare.com"];
        useNetworkd = true;
      };

      systemd.network.enable = true;
    };
  };
}
