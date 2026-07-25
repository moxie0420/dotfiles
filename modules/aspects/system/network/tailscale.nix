{
  system.network.tailscale = {
    nixos = {
      config,
      lib,
      ...
    }: {
      networking = {
        firewall.trustedInterfaces = [config.services.tailscale.interfaceName];
        nftables.enable = lib.mkForce true;
      };

      services.tailscale = {
        enable = true;
        openFirewall = true;
      };

      systemd.services.tailscaled.serviceConfig.Environment = [
        "TS_DEBUG_FIREWALL_MODE=nftables"
      ];
    };
  };
}
