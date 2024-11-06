{
  description = "Moxie's nix config";

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
      ];

      imports = [
        ./hosts
        ./modules
        ./packages
        ./templates
        inputs.git-hooks-nix.flakeModule
        inputs.mkdocs-flake.flakeModule
      ];

      perSystem = {
        pkgs,
        config,
        ...
      }: {
        formatter = pkgs.alejandra;

        devShells.default = pkgs.mkShell {
          name = "Config";
          packages = [pkgs.mkdocs];
          shellHook = config.pre-commit.installationScript;
        };

        documentation.mkdocs-root = ./.;

        pre-commit.settings.hooks = {
          alejandra.enable = true;
          deadnix.enable = true;
          flake-checker.enable = true;
        };
      };
    };

  inputs = {
    # important inputs
    systems.url = "github:nix-systems/default-linux";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # other inputs in alphabetical order
    ags.url = "github:Aylur/ags";

    git-hooks-nix.url = "github:cachix/git-hooks.nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
        hyprwayland-scanner.follows = "hyprland/hyprwayland-scanner";
      };
    };

    hyprpolkitagent = {
      url = "github:hyprwm/hyprpolkitagent";
      inputs = {
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mkdocs-flake.url = "github:applicative-systems/mkdocs-flake";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:fufexan/zen-browser-flake";
  };
}
