{
  inputs,
  self,
  lib,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (self.lib') mkDesktop mkLaptop;

  extraModules = with inputs; [
    self.nixosModules.default
    home-manager.nixosModules.home-manager
    nix-index-database.nixosModules.nix-index
    sops-nix.nixosModules.sops
    stylix.nixosModules.stylix
  ];

  specialArgs = {
    inherit inputs self;
    inherit (self) lib';
  };

  mkContainer = system: modules:
    nixosSystem {
      inherit system;
      modules = lib.flatten [
        modules
        {
          boot.isContainer = true;
          system.stateVersion = "25.05";
        }
      ];
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

  caddy = mkContainer "x86_64-linux" ../containers/caddy.nix;

  jellyfin = mkContainer "x86_64-linux" ../containers/jellyfin.nix;
}
