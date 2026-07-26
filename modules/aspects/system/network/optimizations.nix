{
  system.network.optimizations = {
    nixos = {
      boot = {
        initrd.systemd.network.wait-online.enable = false;

        kernel.sysctl = {
          "net.core.default_qdisc" = "cake";
          # Bufferbloat mitigations + slight improvement in throughput & latency
          "net.ipv4.tcp_congestion_control" = "bbr";
          ## TCP optimization
          # TCP Fast Open is a TCP extension that reduces network latency by packing
          # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
          # both incoming and outgoing connections:
          "net.ipv4.tcp_fastopen" = 3;
        };

        kernelModules = ["tcp_bbr"];
      };

      systemd.network.wait-online.enable = false;
    };
  };
}
