{
  inputs,
  self,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (self.lib') mkDesktop mkLaptop;

  extraModules = with inputs; [
    self.nixosModules.default
    lix-module.nixosModules.default
    home-manager.nixosModules.home-manager
    nix-index-database.nixosModules.nix-index
    chaotic.nixosModules.default
    sops-nix.nixosModules.sops
    stylix.nixosModules.stylix
  ];

  specialArgs = {
    inherit inputs self;
    inherit (self) lib';
  };
in {
  nixUwU = nixosSystem {
    inherit specialArgs;
    modules = mkDesktop ./nixUwU.nix extraModules;
  };

  nixOwO = nixosSystem {
    inherit specialArgs;
    modules = mkLaptop ./nixOwO.nix extraModules;
  };
}
