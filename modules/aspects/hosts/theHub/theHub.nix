{
  lib,
  den,
  self,
  services,
  system,
  ...
}: {
  den.aspects.theHub = {
    includes = [
      den.aspects.theHub.disk-config
      system.hostfile

      services.blocky
      services.caddy
      services.caddy.theHub
      services.immich
    ];

    # host NixOS configuration
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.helix];

      hardware.facter = let
        reportPath = "${self}/modules/aspects/hosts/theHub/facter.json";
      in {
        enable = true;

        reportPath =
          if builtins.pathExists reportPath
          then reportPath
          else throw "Have you forgotten to run nixos-anywhere with `--generate-hardware-config nixos-facter ./facter.json`?";
      };

      home-manager.startAsUserService = true;

      networking.nameservers = lib.mkBefore [
        "192.168.50.138"
      ];

      services.immich.mediaLocation = "/media/storage/Photos";

      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMPsHKCQ0mZQ+pCRlvVYh9MtqSnZJwhyhMktJbz3Axf5 Moxie@MoxieGE.com"
      ];
    };
  };
}
