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
          packages = config.pre-commit.settings.enabledPackages;
          shellHook = config.pre-commit.installationScript;
        };

        documentation.mkdocs-root = ./.;

        pre-commit.settings.hooks = {
          alejandra.enable = true;
          deadnix.enable = true;
          flake-checker.enable = true;
          statix.enable = true;
        };
      };
    };

  inputs = {
    # important inputs
    systems.url = "github:nix-systems/default-linux";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # other inputs in alphabetical order
    git-hooks-nix.url = "github:cachix/git-hooks.nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hypridle.url = "github:hyprwm/hypridle";
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprpaper.url = "github:hyprwm/hyprpaper";

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

    xdg-autostart-hm.url = "github:Zocker1999NET/home-manager-xdg-autostart";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };
}
