{pkgs, ...}: {
  systemd = {
    services = {
      pci-latency = {
        serviceConfig = {
          Type = "oneshot";
        };
        script = ''
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
