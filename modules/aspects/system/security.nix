{
  system.security = {
    nixos = {
      boot = {
        blacklistedKernelModules = [
          # Obscure networking protocols
          "dccp" # Datagram Congestion Control Protocol
          "sctp" # Stream Control Transmission Protocol
          "rds" # Reliable Datagram Sockets
          "tipc" # Transparent Inter-Process Communication
          "n-hdlc" # High-level Data Link Control
          "ax25" # Amateur X.25
          "netrom" # NetRom
          "x25" # X.25
          "rose"
          "decnet"
          "econet"
          "af_802154" # IEEE 802.15.4
          "ipx" # Internetwork Packet Exchange
          "appletalk"
          "psnap" # SubnetworkAccess Protocol
          "p8023" # Novell raw IEE 802.3
          "p8022" # IEE 802.3
          "can" # Controller Area Network
          "atm"

          # Various rare filesystems
          "cramfs"
          "freevxfs"
          "jffs2"
          "hfs"
          "hfsplus"
          "udf"
        ];

        # disable firewire and thunderbolt
        extraModprobeConfig = ''
          install firewire-core /run/current-system/sw/bin/false
          install firewire_core /run/current-system/sw/bin/false
          install firewire-ohci /run/current-system/sw/bin/false
          install firewire_ohci /run/current-system/sw/bin/false
          install firewire_sbp2 /run/current-system/sw/bin/false
          install firewire-sbp2 /run/current-system/sw/bin/false
          install firewire-net  /run/current-system/sw/bin/false
          install thunderbolt   /run/current-system/sw/bin/false
          install ohci1394      /run/current-system/sw/bin/false
          install sbp2          /run/current-system/sw/bin/false
          install dv1394        /run/current-system/sw/bin/false
          install raw1394       /run/current-system/sw/bin/false
          install video1394     /run/current-system/sw/bin/false
        '';

        # To prevent the kernel from ever generating core dumps, make it
        # try to write to a nonexistent directory.  It doesn't work to specify
        # /dev/null; that will cause the kernel to *replace* /dev/null with the
        # core dump if a process running as root dumps core.
        kernel.sysctl."kernel.core_pattern" = "/nonexistent/core";
      };

      security = {
        pam.loginLimits = [
          {
            domain = "*";
            item = "core";
            type = "-";
            value = "0";
          }

          {
            domain = "*";
            item = "nofile";
            type = "-";
            value = "65536";
          }
        ];

        tpm2.enable = true;
      };

      systemd = {
        coredump.enable = false;
        user.settings.Manager = {
          DefaultLimitNOFILE = 65536;
        };
      };
    };
  };
}
