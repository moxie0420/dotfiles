{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    mod = "${self}/common";

    inherit (import mod) desktop laptop;

    specialArgs = {inherit inputs self;};

    shared = {
      home-manager = {
        users.moxie = import ../home;
        extraSpecialArgs = specialArgs;
      };
    };
  in {
    # desktop
    nixUwU = nixosSystem {
      inherit specialArgs;
      modules =
        desktop
        ++ [
          ./nixUwU
          "${mod}/hardware/vr.nix"
          "${mod}/network/spotify.nix"
          "${mod}/services/sunshine.nix"
          shared

          inputs.nix-index-database.nixosModules.nix-index
          inputs.chaotic.nixosModules.default
          inputs.lix-module.nixosModules.default
        ];
    };

    # laptop
    nixOwO = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./nixOwO
          shared

          inputs.nix-index-database.nixosModules.nix-index
          inputs.chaotic.nixosModules.default
          inputs.lix-module.nixosModules.default
        ];
    };
  };
}
