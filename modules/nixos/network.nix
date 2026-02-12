{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.moxie.networking;
in {
  options.moxie.networking = {
    enable = mkEnableOption "Enable my networking config";
    enableDiscovery = mkEnableOption "Enable avahi for network discovery";

    extraNameservers = mkOption {
      default = [];
      description = "etxra nameservers to be added";
      type = types.listOf types.str;
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      networking = {
        nameservers = [
          "1.1.1.1"
          "1.0.0.1"
        ];
        networkmanager = {
          enable = true;
          wifi.backend = "iwd";
        };
        wireless.iwd.enable = true;
      };

      services.tailscale = {
        enable = true;
        extraSetFlags = [
          "--ssh"
        ];
      };
    })

    (mkIf cfg.enableDiscovery {
      services.avahi = {
        enable = mkDefault true;
        nssmdns4 = mkDefault true;
        openFirewall = true;
        publish = {
          enable = mkDefault true;
          domain = mkDefault true;
          userServices = mkDefault true;
        };
      };
    })
  ];
}
