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

    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      flake = {
        templates = {
          "devshell-basic" = {
            path = ./templates/devshell-basic;
            description = "a basic devshell using flake-utils";
          };
        };
        nixosModules.default = {...}: {
          imports = [
            inputs.catppuccin.nixosModules.catppuccin
            inputs.home-manager.nixosModules.home-manager
            inputs.lanzaboote.nixosModules.lanzaboote
            ./modules/common
          ];
        };
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
                inputs.catppuccin.homeManagerModules.catppuccin
              ];
            };
          };
        in {
        };
      };

      systems = [
        "x86_64-linux"
      ];

      imports = [
        ./hosts
        ./common
      ];

      perSystem = {config, ...}: {
        formatter = inputs.alejandra.defaultPackage;
      };
    };
}
