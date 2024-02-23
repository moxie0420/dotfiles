{
  description = "Moxie's nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    
    # beta wayland packages
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    spicetify-nix.url = "github:the-argus/spicetify-nix";

    # nix themeing
    stylix.url = "github:danth/stylix";

    #declareative disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # extra home-manager modules
    xhmm.url = "github:schuelermine/xhmm";
  };

  outputs = { nixpkgs, lanzaboote, hyprland, home-manager, spicetify-nix, chaotic, stylix, disko, nixpkgs-wayland, ... } @ inputs: rec {
    nixosConfigurations = {
      # home desktop
      nixUwU = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [ 
      	  ./hw/nixUwU
          hyprland.nixosModules.default
          stylix.nixosModules.stylix
	        chaotic.nixosModules.default
	        home-manager.nixosModules.home-manager {
	          home-manager.extraSpecialArgs = {inherit spicetify-nix;};
	          home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.moxie = import ./home;
	        }
        ];
      };

      # school laptop
      nixOwO = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
      	system = "x86_64-linux";
      	modules = [
          ./hw/nixOwO
				  lanzaboote.nixosModules.lanzaboote
				  stylix.nixosModules.stylix
				  chaotic.nixosModules.default
				  home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {inherit spicetify-nix;};
					  home-manager.useGlobalPkgs = true;
           	home-manager.useUserPackages = true;
					  home-manager.users.moxie = import ./home;
				  }
				];
			};

      "jbod" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
      	system = "x86_64-linux";
        modules = [
          ./hw/jbod
          disko.nixosModules.disko
        ];
      };

      piTime = nixpkgs.lib.nixosSystem {
        modules = [
          (nixpkgs + /nixos/modules/installer/sd-card/sd-image-aarch64.nix)
          {
            nixpkgs.config.allowUnsupportedSystem = true;
            nixpkgs.hostPlatform.system = "aarch64-linux";
            nixpkgs.buildPlatform.system = "x86_64-linux";
          }
          ./hw/piTime
        ];
      };
    };
    images.piTime = nixosConfigurations.piTime.config.system.build.sdImage;
  };
}

