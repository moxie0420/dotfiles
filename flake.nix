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
    zen-browser.url = "github:MarceColl/zen-browser-flake";

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    alejandra,
    self,
    nixpkgs,
    lanzaboote,
    home-manager,
    spicetify-nix,
    catppuccin,
    ...
  } @ inputs: {
    templates = {
      "devshell-basic" = {
        path = ./templates/devshell-basic;
        description = "a basic devshell using flake-utils";
      };
    };

    formatter."x86_64-linux" = alejandra.defaultPackage."x86_64-linux";

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
          backupFileExtension = "backup";
          extraSpecialArgs = {inherit inputs;};
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
        modules = [./hw/nixUwU] ++ commonModules;
      };

      # laptop
      nixOwO = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./hw/nixOwO] ++ commonModules;
      };
    };
  };
}
