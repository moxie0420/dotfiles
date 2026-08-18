{
  inputs,
  self,
  ...
}: {
  flake = {
    checks =
      builtins.mapAttrs (
        system: deployLib: deployLib.deployChecks self.deploy
      )
      inputs.deploy-rs.lib;

    deploy.nodes = {
      theHub = {
        hostname = "192.168.50.138";

        profiles.system = {
          path = inputs.deploy-rs.lib."x86_64-linux".activate.nixos self.nixosConfigurations.theHub;
          sshUser = "root";
        };
      };
    };
  };

  flake-file.inputs.deploy-rs = {
    url = "github:serokell/deploy-rs";
  };
}
