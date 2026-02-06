{
  description = "Moxie's nix config";

  outputs = inputs @ {
    self,
    home-manager,
    nixpkgs,
    ...
  }: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];

    eachSystem = accu: system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      accu
      // {
        legacyPackages =
          (accu.legacyPackages or {})
          // {
            ${system} = accu.lib'.applyOverlay {inherit pkgs;};
          };

        packages =
          (accu.packages or {})
          // {
            ${system} = accu.lib'.applyOverlay {
              inherit pkgs;
              onlyDerivations = true;
            };
          };

        formatter =
          (accu.formatter or {})
          // {
            ${system} = pkgs.alejandra;
          };
      };

    universals = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      inherit (inputs.nixpkgs) lib;
    in {
      schemas = import ./schemas.nix {inherit inputs;};

      # Overlays that contain all of this repos packages
      #
      # A lot of the design for this came form chaotic-cx/nyx
      # https://github.com/chaotic-cx/nyx
      overlays = {
        default = import ./overlays;
        cache-friendly = import ./overlays/cache-friendly.nix {inherit inputs;};
      };

      nixosConfigurations = import ./hosts {inherit self inputs lib;};

      homeConfigurations.moxie = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs self;
          inherit (self) lib';
        };
        modules = with inputs; [
          self.homeModules.default
          stylix.homeModules.stylix
          ./home
          {
            programs.home-manager.enable = true;
          }
        ];
      };

      # NixOS & Home-Manager Modules
      nixosModules = import ./modules/nixos {inherit inputs;};
      homeModules = import ./modules/home-manager;
      homeManagerModules = self.homeModules;

      # My Util Functions
      #
      # Like the Overlays the setup for this is based on chaotic-cx/nyx
      # https://github.com/chaotic-cx/nyx
      lib' = import ./lib {
        moxieOverlay = self.overlays.default;
        inherit self lib;
      };
    };
  in
    builtins.foldl' eachSystem universals systems;

  inputs = {
    flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/=0.1.5.tar.gz";
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # other inputs in alphabetical order
    agenix.url = "github:ryantm/agenix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";
    hyprlock.url = "github:ShadowBahamut/hyprlock-animated";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
