{pkgs, ...}: {
  services = {
    journald.extraConfig = ''
      SystemMaxUse=50M
    '';

    timesyncd = {
      servers = [
        "time.cloudflare.com"
      ];

      fallbackServers = [
        "time.google.com"
        "0.arch.pool.ntp.org"
        "1.arch.pool.ntp.org"
        "2.arch.pool.ntp.org"
        "3.arch.pool.ntp.org"
      ];
    };
  };

  systemd = {
    user.extraConfig = ''
      [Manager]
      DefaultLimitNOFILE=1024:1048576
    '';
    coredump.enable = false;

    settings.Manager = {
      DefaultTimeoutStartSec = "15s";
      DefaultTimeoutStopSec = "10s";
      RebootWatchdogSec = "45s";
      RuntimeWatchdogSec = "30s";
      DefaultLimitNOFILE = "2048:2097152";
    };

    tmpfiles.rules = [
      "w! /sys/kernel/mm/transparent_hugepage/defrag - - - - defer+madvise"
      "w! /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none - - - - 409"
      "d /var/lib/systemd/coredump 0755 root root 3d"
    ];

    services = {
      pci-latency = {
        serviceConfig = {
          Type = "oneshot";
        };
        script = ''
          if [ "$(id -u)" -ne 0 ]; then
            echo "Error: This script must be run with root privileges." >&2
            exit 1
          fi

          # Reset the latency timer for all PCI devices
          ${pkgs.pciutils}/bin/setpci -v -s '*:*' latency_timer=20
          ${pkgs.pciutils}/bin/setpci -v -s '0:0' latency_timer=0

          # Set latency timer for all sound cards
          ${pkgs.pciutils}/bin/setpci -v -d "*:*:04xx" latency_timer=80
        '';
        wantedBy = ["multi-user.target"];
      };
    };
  };
}
