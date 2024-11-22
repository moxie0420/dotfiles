{
  flake = {
    homeModules = rec {
      rose-pine = import ./rose-pine;
      default = rose-pine;
    };
  };
}
