{lib, ...}: let
  inherit (lib.strings) concatStringsSep;

  options = import ./options.nix {inherit lib;};
  toLines = concatStringsSep "\n";
in {
  inherit toLines;
  inherit (options) mkEnabledOption mkFollowsOption;
  # import other lib parts
  colorschemes = import ./colorschemes.nix;
  description = "Functions that i use around my config and modules";
  disks = import ./disks {inherit lib;};
  hyprland = import ./hyprland.nix {inherit lib toLines;};
  kernelConfigs = import ./kernel {inherit lib;};
  networking = import ./networking;
  pipewire = import ./pipewire.nix {inherit lib;};
  # General functions
  recurseForDerivations = false;
}
