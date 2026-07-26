{
  services.blocky = {
    firewall = {
      tcpPorts = [53];
      udpPorts = [53];
    };

    nixos.services.blocky = {
      enable = true;

      settings = {
        #Enable Blocking of certain domains.
        blocking = {
          #Configure what block categories are used
          clientGroupsBlock = {
            default = ["ads"];
          };

          denylists = {
            #Adblocking
            ads = ["https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/pro.txt"];
            #You can add additional categories
          };
        };

        # For initially solving DoH/DoT Requests when no system Resolver is available.
        bootstrapDns = {
          ips = [
            "1.1.1.1"
            "1.0.0.1"
          ];

          upstream = "https://one.one.one.one/dns-query";
        };

        caching = {
          maxTime = "30m";
          minTime = "5m";
          prefetching = true;
        };

        customDNS = {
          customTTL = "1h";

          mapping = {
            # Services
            "immich.lan" = "192.168.50.138";
            # Machines
            "thehub.lan" = "192.168.50.138";
          };
        };

        ports.dns = 53; # Port for incoming DNS Queries.

        upstreams.groups.default = [
          "https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
        ];
      };
    };
  };
}
