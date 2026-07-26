{den, ...}: let
  inherit (den.lib.policy) pipe;
in {
  den = {
    policies = {
      collect-backends = {host, ...}: [
        (pipe.from "http-backends" [
          (pipe.collect ({host, ...}: true))
        ])
      ];

      collect-host-addrs = {host, ...}: [
        (pipe.from "host-addrs" [
          (pipe.collect ({host, ...}: true))
        ])
      ];
    };

    quirks = {
      host-addrs = {
        description = "Host address entries for /etc/hosts generation";
      };

      http-backends = {
        description = "HTTP backend addresses for load balancer aggregation";
      };
    };

    schema.host.includes = [
      den.policies.collect-backends
      den.policies.collect-host-addrs
    ];
  };
}
