# deadnix: skip
final: prev: {
  inherit (prev.lixPackageSets.latest) nixpkgs-review nix-eval-jobs nix-fast-build colmena;
}
