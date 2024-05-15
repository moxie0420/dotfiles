{
  description = "Moxie's nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Hyprland and utils
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprlock.url = "github:hyprwm/hyprlock";
    hypridle.url = "github:hyprwm/hypridle";

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

    pnpm2nix.url = "github:nzbr/pnpm2nix-nzbr";
  };

  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    hyprland,
    hypridle,
    hyprlock,
    hyprpaper,
    home-manager,
    spicetify-nix,
    chaotic,
    stylix,
    disko,
    xhmm,
    nixpkgs-wayland,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      # home desktop
      nixUwU = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hw/nixUwU
          hyprland.nixosModules.default
          stylix.nixosModules.stylix
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {inherit inputs outputs;};
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.moxie = import ./home;
          }
        ];
      };

      # school laptop
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
            home-manager.users.moxie = import ./home;
          }
        ];
      };

      "jbod" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hw/jbod
          disko.nixosModules.disko
        ];
      };
    };
  };
}
