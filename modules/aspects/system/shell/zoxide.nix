{lib, ...}: let
  flags = ["--cmd cd"];

  mkZoxideOptions = options: flags: let
    inherit (lib.attrsets) optionalAttrs;
    inherit (options.programs) zoxide;

    handleFlags = optionalAttrs (zoxide ? "flags") {
      flags = flags;
    };
    handleOptions = optionalAttrs (zoxide ? "options") {
      options = flags;
    };
  in {
    programs.zoxide =
      {
        enable = true;
      }
      // handleFlags // handleOptions;
  };
in {
  system.shell.zoxide = {
    nixos = {options, ...}: mkZoxideOptions options flags;
    homeManger = {options, ...}: mkZoxideOptions options flags;
  };
}
