{
  description = "Moxie's nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    # user config
    home-manager = {
      url = "github:nix-community/home-manager";
    };

    # secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spotify themeing
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix themeing
    stylix.url = "github:danth/stylix";

    musnix.url = "github:musnix/musnix";
  };

  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    home-manager,
    spicetify-nix,
    chaotic,
    stylix,
    musnix,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      # desktop
      nixUwU = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hw/nixUwU
          stylix.nixosModules.stylix
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {inherit inputs outputs;};
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.moxie = import ./home;
            home-manager.backupFileExtension = "bak";
          }
        ];
      };

      # laptop
      nixOwO = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hw/nixOwO
          lanzaboote.nixosModules.lanzaboote
          stylix.nixosModules.stylix
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {inherit inputs outputs;};
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.users.moxie = import ./home;
          }
        ];
      };
    };
  };
}
