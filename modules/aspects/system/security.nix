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
          "netrom"
          "rose"

          # Old or rare or insufficiently audited filesystems
          "adfs"
          "affs"
          "bfs"
          "befs"
          "cramfs"
          "efs"
          "erofs"
          "exofs"
          "freevxfs"
          "f2fs"
          "hfs"
          "hpfs"
          "hfsplus"
          "jfs"
          "jffs2"
          "minix"
          "nilfs2"
          "ntfs"
          "omfs"
          "qnx4"
          "qnx6"
          "sysv"
          "ufs"
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
        kernel.sysctl = {
          # To prevent the kernel from ever generating core dumps, make it
          # try to write to a nonexistent directory.  It doesn't work to specify
          # /dev/null; that will cause the kernel to *replace* /dev/null with the
          # core dump if a process running as root dumps core.
          "kernel.core_pattern" = "/nonexistent/core";
          # Disable ftrace debugging
          "kernel.ftrace_enabled" = false;
          # Disable io_uring, a large source of security vulnerabilities
          # https://security.googleblog.com/2023/06/learnings-from-kctf-vrps-42-linux.html
          "kernel.io_uring_disabled" = 2;
          # Hide kptrs even for processes with CAP_SYSLOG
          "kernel.kptr_restrict" = "2";
          # Disable bpf() JIT (to eliminate spray attacks)
          "net.core.bpf_jit_enable" = false;
          # Ignore incoming ICMP redirects (note: default is needed to ensure that the
          # setting is applied to interfaces added after the sysctls are set)
          "net.ipv4.conf.all.accept_redirects" = false;
          # Enable strict reverse path filtering (that is, do not attempt to route
          # packets that "obviously" do not belong to the iface's network; dropped
          # packets are logged as martians).
          "net.ipv4.conf.all.log_martians" = true;
          "net.ipv4.conf.all.rp_filter" = "1";
          "net.ipv4.conf.all.secure_redirects" = false;
          # Ignore outgoing ICMP redirects (this is ipv4 only)
          "net.ipv4.conf.all.send_redirects" = false;
          "net.ipv4.conf.default.accept_redirects" = false;
          "net.ipv4.conf.default.log_martians" = true;
          "net.ipv4.conf.default.rp_filter" = "1";
          "net.ipv4.conf.default.secure_redirects" = false;
          "net.ipv4.conf.default.send_redirects" = false;
          # Ignore broadcast ICMP (mitigate SMURF)
          "net.ipv4.icmp_echo_ignore_broadcasts" = true;
          "net.ipv6.conf.all.accept_redirects" = false;
          "net.ipv6.conf.default.accept_redirects" = false;
        };
        kernelParams = [
          # Don't merge slabs
          "slab_nomerge"
          # Overwrite free'd pages
          "page_poison=1"
          # Enable page allocator randomization
          "page_alloc.shuffle=1"
        ];
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
