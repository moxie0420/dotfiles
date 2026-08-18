{inputs, ...}: {
  den.aspects.secrets.nixos = {
    environment.systemPackages = builtins.attrValues {
      inherit (inputs.agenix.packages.x86_64-linux) default;
    };

    imports = [inputs.agenix.nixosModules.default];
  };

  flake-file.inputs.agenix = {
    url = "github:ryantm/agenix";
  };
}
