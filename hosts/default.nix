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
        users.moxie.imports = [
          ../home
          self.homeManagerModules.rose-pine
          {
            rose-pine.enable = true;
          }
        ];
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
          shared
        ];
    };

    # laptop
    nixOwO = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./nixOwO
          "${mod}/hardware/specialisations.nix"
          shared
        ];
    };
  };
}
