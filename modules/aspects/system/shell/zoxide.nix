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
      // handleFlags
      // handleOptions;
  };
in {
  system.shell.zoxide = {
    homeManger = {options, ...}: mkZoxideOptions options flags;
    nixos = {options, ...}: mkZoxideOptions options flags;
  };
}
