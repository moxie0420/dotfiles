{
  den,
  inputs,
  self,
  ...
}: {
  flake-file.inputs.authentik-nix.url = "github:nix-community/authentik-nix";

  services.authentik = {
    includes = [
      den.aspects.secrets
    ];

    nixos = {config, ...}: {
      age.secrets = {
        authentik.file = "${self}/secrets/authentik.age";
        authentik-ldap.file = "${self}/secrets/authentik-ldap.age";
      };

      imports = [
        inputs.authentik-nix.nixosModules.default
      ];

      services = {
        authentik = {
          enable = true;
          environmentFile = config.age.secrets.authentik.path;

          settings = {
            disable_startup_analytics = true;
          };
        };

        authentik-ldap = {
          enable = false;
          environmentFile = config.age.secrets.authentik-ldap.path;
        };
      };
    };
  };
}
