{
  description = "Moxie's nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # user config
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    home-manager,
    spicetify-nix,
    catppuccin,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = let
      home = {
        catppuccin = {
          enable = true;
          accent = "pink";
          flavor = "mocha";
        };
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "bak";
          extraSpecialArgs = {inherit inputs outputs;};
          users.moxie.imports = [
            ./home/home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };

      commonModules = [
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        lanzaboote.nixosModules.lanzaboote
        home
      ];
    in {
      # desktop
      nixUwU = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [./hw/nixUwU] ++ commonModules;
      };

      # laptop
      nixOwO = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [./hw/nixOwO] ++ commonModules;
      };
    };
  };
}
