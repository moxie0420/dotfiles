{
  den,
  inputs,
  lib,
  self,
  ...
}: let
  commonOpts = {
    # Disable nix channels. Use flakes instead.
    channel.enable = lib.mkDefault false;

    settings = rec {
      # Fallback quickly if substituters are not available.
      connect-timeout = lib.mkDefault 5;
      fallback = true;

      # Enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      log-lines = lib.mkDefault 25;

      # Avoid disk full issues
      max-free = lib.mkDefault (3000 * 1024 * 1024);
      min-free = lib.mkDefault (512 * 1024 * 1024);

      builders-use-substitutes = true;

      trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
        "https://numtide.cachix.org"
        "https://attic.xuyh0120.win/lantian"
      ];

      substituters = trusted-substituters;

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      ];
    };
  };
in {
  flake-file.inputs.nix-index-database = {
    url = "github:nix-community/nix-index-database";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  system.nix = {
    includes = [
      den.aspects.git
    ];

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
      in
        {
          # Use lix instead of reference nix
          package = pkgs.lixPackageSets.latest.lix;

          daemonCPUSchedPolicy = lib.mkDefault "batch";
          daemonIOSchedClass = lib.mkDefault "idle";
          daemonIOSchedPriority = lib.mkDefault 7;

          optimise.automatic = lib.mkDefault (!config.boot.isContainer);

          settings.trusted-users = ["@wheel"];

          registry = lib.mapAttrs (_: flake: {inherit flake;}) flake-inputs;
          nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flake-inputs;
        }
        // commonOpts;

      nixpkgs.overlays = [
        (import "${self}/overlays/lix.nix")
        (import "${self}/overlays/default.nix")
      ];

      programs = {
        nh = {
          enable = true;
          clean.enable = true;
          clean.extraArgs = "--keep 5 --keep-since 3d";
          flake = "/home/moxie/dotfiles";
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
      (import "${self}/overlays/lix.nix")
      (import "${self}/overlays/default.nix")
    ];
  };
}
