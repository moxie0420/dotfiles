{inputs, ...}: {
  den.aspects.secrets.nixos = {
    imports = [inputs.agenix.nixosModules.default];

    environment.systemPackages = builtins.attrValues {
      inherit (inputs.agenix.packages.x86_64-linux) default;
    };
  };

  flake-file.inputs.agenix = {
    inputs = {
      home-manager.follows = "home-manager";
      nixpkgs.follows = "nixpkgs";
    };

    url = "github:ryantm/agenix";
  };
}
