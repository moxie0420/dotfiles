{
  description = "Moxie's RPI3B nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    hyprland.url = "github:hyprwm/Hyprland";

    # user config
    home-manager = {
    	url = "github:nix-community/home-manager";
    	inputs.nixpkgs.follows = "nixpkgs";
    };

    # spotify themeing
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = {nixpkgs, hyprland, home-manager, spicetify-nix, chaotic, ... } @ inputs: rec {
    nixosConfigurations = {
      nixUwU = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [ 
      	  ./hw/nixUwU
	        chaotic.nixosModules.default
	        home-manager.nixosModules.home-manager {
	          home-manager.extraSpecialArgs = {inherit spicetify-nix;};
	          home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.moxie = import ./home;
	        }
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
          ./config.nix
        ];
      };
    };
    images.piTime = nixosConfigurations.piTime.config.system.build.sdImage;
  };
}
