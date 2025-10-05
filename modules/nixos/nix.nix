{
  lib,
  pkgs,
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
    daemonIOSchedPriority = 0;
    registry.nixpkgs.to = {
      inherit (pkgs) path;
      type = "path";
      narHash =
        builtins.readFile
        (
          pkgs.runCommandLocal "get-nixpkgs-hash" {
            nativeBuildInputs = [pkgs.lix];
          }
          "nix --experimental-features nix-command hash path --type sha256 --sri ${pkgs.path} > $out"
        );
    };
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];

      keep-outputs = true;

      trusted-users = ["root" "@wheel"];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      warn-dirty = false;
    };
  };

  nixpkgs.config.allowUnfree = lib.mkForce true;
}
