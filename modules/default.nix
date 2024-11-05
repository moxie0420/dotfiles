{
  flake = {
    hmModules = rec {
      rose-pine = import ./rose-pine;
      default = rose-pine;
    };
  };
}
