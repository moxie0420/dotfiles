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
      catppuccin = {
        enable = true;
        accent = "pink";
        flavor = "mocha";
      };
      home-manager = {
        users.moxie.imports = [
          ../home
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.nix-index-database.hmModules.nix-index
          self.homeManagerModules.rosePine
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

          inputs.catppuccin.nixosModules.catppuccin
          inputs.nix-index-database.nixosModules.nix-index
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

          inputs.catppuccin.nixosModules.catppuccin
          inputs.nix-index-database.nixosModules.nix-index
        ];
    };
  };
}
