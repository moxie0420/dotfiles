{
  description = "Moxie's nix config";

  outputs = inputs @ {
    self,
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

    universals = {
      schemas = import ./schemas.nix {inherit inputs;};

      # Overlays that contain all of this repos packages
      #
      # A lot of the design for this came form chaotic-cx/nyx
      # https://github.com/chaotic-cx/nyx
      overlays = {
        default = import ./overlays;
        cache-friendly = import ./overlays/cache-friendly.nix {inherit inputs;};
      };

      nixosConfigurations = import ./hosts {inherit self inputs;};

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
        inherit self;
        inherit (inputs.nixpkgs) lib;
      };
    };
  in
    builtins.foldl' eachSystem universals systems;

  inputs = {
    flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/=0.1.5.tar.gz";

    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };

    nixpkgs.url = "nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # other inputs in alphabetical order
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
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
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
