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

    shared = {config, ...}: {
      home-manager = {
        users.moxie = import ../home;
        extraSpecialArgs = {
          inherit inputs self;
          inherit (config.networking) hostName;
        };
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
          inputs.sops-nix.nixosModules.sops
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
        ];
    };
  };
}
