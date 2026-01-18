{lib, ...}: let
  inherit (lib.lists) flatten;
in {
  btrfs = import ./btrfs.nix;

  defaults = extra: flatten ["noatime" extra];
}
