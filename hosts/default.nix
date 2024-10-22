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

          {
            catppuccin = {
              enable = true;
              accent = "pink";
              flavor = "mocha";
            };
            home-manager = {
              users.moxie.imports = [
                "${self}/home"
                inputs.catppuccin.homeManagerModules.catppuccin
              ];
              extraSpecialArgs = specialArgs;
            };
          }

          inputs.catppuccin.nixosModules.catppuccin
        ];
    };

    # laptop
    nixOwO = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./nixOwO
        ];
    };
  };
}
