{lib}: let
  inherit (lib) mkOption;

  mkEnabledOption = name:
    mkOption {
      default = true;
      example = false;
      description = "Whether to enable ${name}.";
      type = lib.types.bool;
    };

  mkFollowsOption = follows:
    mkOption {
      default = follows;
      example = false;
      description = "Follows ${follows}";
      type = lib.types.${builtins.typeOf follows};
    };
in {
  inherit mkEnabledOption mkFollowsOption;
}
