{
	description = "A SecureBoot-enabled NixOS configurations";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		lanzaboote = {
			url = "github:nix-community/lanzaboote";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
		home-manageri = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		stylix.url = "github:danth/stylix";
	};

	outputs = { nixpkgs, lanzaboote,  chaotic, home-manager, stylix, ... }: {
    		nixosConfigurations = {
			nixOwO = nixpkgs.lib.nixosSystem {
      				system = "x86_64-linux";
      				modules = [ 
					lanzaboote.nixosModules.lanzaboote
					stylix.nixosModules.stylix
					chaotic.nixosModules.default
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
            			home-manager.useUserPackages = true;
						home-manager.users.moxie = import ./users.nix;
					}
					./configuration.nix
				];
			};
    		};
  	};
}
