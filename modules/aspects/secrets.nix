{inputs, ...}: {
  flake-file.inputs.agenix.url = "github:ryantm/agenix";

  den.aspects.secrets.nixos = {
    imports = [inputs.agenix.nixosModules.default];
    age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    environment.systemPackages = builtins.attrValues {
      inherit (inputs.agenix.packages.x86_64-linux) default;
    };
  };
}
