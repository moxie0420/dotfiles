{lib}: let
  inherit (lib) mkOption;

  mkEnabledOption = name:
    mkOption {
      default = true;
      description = "Whether to enable ${name}.";
      example = false;
      type = lib.types.bool;
    };

  mkFollowsOption = follows:
    mkOption {
      default = follows;
      description = "Follows ${follows}";
      example = false;
      type = lib.types.${builtins.typeOf follows};
    };
in {
  inherit mkEnabledOption mkFollowsOption;
}
