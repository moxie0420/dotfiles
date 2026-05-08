{lib, ...}: let
  inherit (lib.strings) concatStringsSep;

  options = import ./options.nix {inherit lib;};
  toLines = concatStringsSep "\n";
in {
  _description = "Functions that i use around my config and modules";

  inherit toLines;
  inherit (options) mkEnabledOption mkFollowsOption;

  # import other lib parts
  colorschemes = import ./colorschemes.nix;
  disks = import ./disks {inherit lib;};
  hyprland = import ./hyprland.nix {inherit lib toLines;};
  kernelConfigs = import ./kernel {inherit lib;};
  pipewire = import ./pipewire.nix {inherit lib;};

  # General functions
  recurseForDerivations = false;
}
