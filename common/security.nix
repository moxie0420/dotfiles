{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.kernel.sysctl = {
    ## TCP optimization
    # TCP Fast Open is a TCP extension that reduces network latency by packing
    # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
    # both incoming and outgoing connections:
    "net.ipv4.tcp_fastopen" = 3;
    # Bufferbloat mitigations + slight improvement in throughput & latency
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };

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

    extraModprobeConfig = ''
      # firewire and thunderbolt
      install firewire-core /bin/false
      install firewire_core /bin/false
      install firewire-ohci /bin/false
      install firewire_ohci /bin/false
      install firewire_sbp2 /bin/false
      install firewire-sbp2 /bin/false
      install firewire-net /bin/false
      install thunderbolt /bin/false
      install ohci1394 /bin/false
      install sbp2 /bin/false
      install dv1394 /bin/false
      install raw1394 /bin/false
      install video1394 /bin/false
    '';

    kernelModules = ["tcp_bbr"];
  };

  security = {
    allowUserNamespaces = true;
    unprivilegedUsernsClone = config.virtualisation.containers.enable;
    allowSimultaneousMultithreading = true;

    polkit = {
      enable = true;
      adminIdentities = [
        "unix-group:wheel"
      ];
      extraConfig = lib.mkMerge [
        ''
          polkit.addRule(function (action, subject) {
            if (
              subject.isInGroup("users") &&
              [
                "org.freedesktop.login1.reboot",
                "org.freedesktop.login1.reboot-multiple-sessions",
                "org.freedesktop.login1.power-off",
                "org.freedesktop.login1.power-off-multiple-sessions",
                "org.freedesktop.NetworkManager.enable-disable-network",
                "org.freedesktop.NetworkManager.enable-disable-wifi",
                "org.freedesktop.NetworkManager.enable-disable-wimax",
                "org.freedesktop.NetworkManager.enable-disable-wwan",
                "org.freedesktop.NetworkManager.network-control",
                "org.freedesktop.NetworkManager.wifi.scan",
                "org.freedesktop.NetworkManager.wifi.share.open",
                "org.freedesktop.NetworkManager.wifi.share.protected",
                "org.freedesktop.NetworkManager.settings.modify.own",
                "org.freedesktop.NetworkManager.settings.modify.system"
              ].indexOf(action.id) !== -1
            ) {
              return polkit.Result.YES;
            }
          });
        ''
      ];
    };

    pam = {
      loginLimits = [
        {
          domain = "*"; # Applies to all users/sessions
          type = "-"; # Set both soft and hard limits
          item = "core"; # The soft/hard limit item
          value = "0"; # Core dumps size is limited to 0 (effectively disabled)
        }
      ];
      services.hyprlock = {
        text = ''
          auth include login
          account include login
          password include login
          session include login
        '';
      };
    };

    rtkit.enable = true;

    tpm2 = {
      enable = true;
      pkcs11.enable = false;
      tctiEnvironment.enable = true;
    };
  };

  systemd = {
    coredump.enable = false;

    user.services.olkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
