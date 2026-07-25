{den, ...}: let
  inherit (den.lib.policy) pipe;
in {
  den.policies.collect-backends = {host, ...}: [
    (pipe.from "http-backends" [
      (pipe.collect ({host, ...}: true))
    ])
  ];
  den.policies.collect-host-addrs = {host, ...}: [
    (pipe.from "host-addrs" [
      (pipe.collect ({host, ...}: true))
    ])
  ];
  den.quirks.host-addrs = {
    description = "Host address entries for /etc/hosts generation";
  };
  den.quirks.http-backends = {
    description = "HTTP backend addresses for load balancer aggregation";
  };
  den.schema.host.includes = [
    den.policies.collect-backends
    den.policies.collect-host-addrs
  ];
}
