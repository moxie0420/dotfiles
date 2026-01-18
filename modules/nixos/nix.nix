{
  lib,
  pkgs,
  self,
  ...
}: {
  programs = {
    git = {
      enable = true;
      lfs = {
        enable = true;
        enablePureSSHTransfer = true;
      };
    };
    nh = {
      enable = true;
      # weekly cleanup
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d";
      };
    };
    nix-index-database.comma.enable = true;
  };

  nix = {
    # Use lix instead of reference nix
    package = pkgs.lixPackageSets.latest.lix;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];

      keep-outputs = true;

      trusted-users = ["root" "@wheel"];

      substituters = [
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      warn-dirty = false;
    };
  };

  nixpkgs = {
    config.allowUnfree = lib.mkForce true;

    overlays = [
      (import "${self}/overlays/lix.nix")
    ];
  };
}
