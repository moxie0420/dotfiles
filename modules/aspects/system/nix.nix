{
  lib,
  inputs,
  programs,
  system,
  ...
}: {
  flake-file.inputs.nix-index-database = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:nix-community/nix-index-database";
  };

  system.nix = {
    includes = [
      programs.git
    ];

    nixos = {
      config,
      pkgs,
      ...
    }: {
      environment.systemPackages = builtins.attrValues {
        inherit
          (pkgs)
          nixd
          nixfmt
          ;
      };

      imports = [inputs.nix-index-database.nixosModules.default];

      nix = let
        flake-inputs = lib.filterAttrs (_: lib.isType "flake") inputs;
      in {
        # Disable nix channels. Use flakes instead.
        channel.enable = lib.mkDefault false;
        daemonCPUSchedPolicy = lib.mkDefault "batch";
        daemonIOSchedClass = lib.mkDefault "idle";
        daemonIOSchedPriority = lib.mkDefault 7;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flake-inputs;
        optimise.automatic = lib.mkDefault (!config.boot.isContainer);
        registry = lib.mapAttrs (_: flake: {inherit flake;}) flake-inputs;

        settings = {
          # Deduplicate the nix store
          auto-optimise-store = true;
          builders-use-substitutes = true;
          # Fallback quickly if substituters are not available.
          connect-timeout = lib.mkDefault 5;
          # increase download buffer to 500 MiB
          download-buffer-size = 500 * 1048576;

          # Enable flakes
          experimental-features = [
            "nix-command"
            "flakes"
          ];

          fallback = true;

          substituters = [
            "https://nix-community.cachix.org"
          ];

          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];

          # set trusted users
          trusted-users = ["madelyn"];
        };
      };

      programs = {
        nh = {
          clean = {
            enable = true;
            extraArgs = "--keep 1";
          };

          enable = true;
          flake = "/home/madelyn/dotfiles";
        };

        nix-index-database.comma.enable = true;
      };
    };

    provides.to-users.includes = [system.nix];
  };
}
