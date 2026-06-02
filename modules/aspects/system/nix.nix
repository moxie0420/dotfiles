{
  classes,
  den,
  inputs,
  lib,
  self,
  ...
}: {
  flake-file.inputs.nix-index-database = {
    url = "github:nix-community/nix-index-database";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  system.nix = {
    includes = [
      classes.nix
      den.aspects.git
    ];

    nix = rec {
      # Deduplicate the nix store
      auto-optimise-store = true;

      # Fallback quickly if substituters are not available.
      connect-timeout = lib.mkDefault 5;
      fallback = true;

      # increase download buffer to 500 MiB
      download-buffer-size = 500 * 1048576;

      # Enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # set trusted users
      trusted-users = ["root" "madeline" "@wheel"];

      log-lines = lib.mkDefault 25;

      # Avoid disk full issues
      max-free = lib.mkDefault (3000 * 1024 * 1024);
      min-free = lib.mkDefault (512 * 1024 * 1024);

      builders-use-substitutes = true;

      trusted-substituters = [
        "https://nix-community.cachix.org"
      ];

      substituters = trusted-substituters;

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    nixos = {
      config,
      pkgs,
      lib,
      ...
    }: {
      imports = [inputs.nix-index-database.nixosModules.default];

      environment.systemPackages = builtins.attrValues {
        inherit
          (pkgs)
          gitFull
          nixd
          nixfmt
          ;
      };

      nix = let
        flake-inputs = lib.filterAttrs (_: lib.isType "flake") inputs;
      in {
        # Use lix instead of reference nix
        # package = pkgs.lixPackageSets.latest.lix;

        daemonCPUSchedPolicy = lib.mkDefault "batch";
        daemonIOSchedClass = lib.mkDefault "idle";
        daemonIOSchedPriority = lib.mkDefault 7;

        optimise.automatic = lib.mkDefault (!config.boot.isContainer);

        registry = lib.mapAttrs (_: flake: {inherit flake;}) flake-inputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flake-inputs;

        # Disable nix channels. Use flakes instead.
        channel.enable = lib.mkDefault false;
      };

      nixpkgs.overlays = [
        # (import "${self}/overlays/lix.nix")
        (import "${self}/overlays/default.nix")
      ];

      programs = {
        nh = {
          enable = true;
          clean.enable = true;
          clean.extraArgs = "--keep 5 --keep-since 3d";
          flake = "/home/madeline/dotfiles";
        };
        nix-index-database.comma.enable = true;
      };

      systemd.services = {
        nix-daemon.serviceConfig.OOMScoreAdjust = lib.mkDefault 250;
        nix-gc.serviceConfig = {
          CPUSchedulingPolicy = "batch";
          IOSchedulingClass = "idle";
          IOSchedulingPriority = 7;
        };
      };
    };

    homeManager.nixpkgs.overlays = [
      # (import "${self}/overlays/lix.nix")
      (import "${self}/overlays/default.nix")
    ];
  };
}
