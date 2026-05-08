{
  inputs,
  self,
  ...
}: {
  flake-file.inputs.agenix.url = "github:ryantm/agenix";

  den.aspects.secrets.nixos = {
    imports = [inputs.agenix.nixosModules.default];
    age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    # Secrets
    age.secrets = {
      qbittorrent.file = "${self}/secrets/qbittorrent.age";
      homarr.file = "${self}/secrets/homarr.age";
      authentik.file = "${self}/secrets/authentik.age";
      authentik-ldap.file = "${self}/secrets/authentik-ldap.age";
      sonarr-key = {
        file = "${self}/secrets/sonarr-key.age";
        group = "nixarr";
      };
      radarr-key = {
        file = "${self}/secrets/radarr-key.age";
        group = "nixarr";
      };
    };

    environment.systemPackages = builtins.attrValues {
      inherit (inputs.agenix.packages.x86_64-linux) default;
    };
  };
}
