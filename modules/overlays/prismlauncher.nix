{
  flake.overlays.prismlauncher = final: prev: {
    prismlauncher = prev.prismlauncher.override {
      jdks = builtins.attrValues {
        inherit
          (prev)
          temurin-bin-21
          temurin-bin-17
          temurin-bin-8
          ;
      };
    };
  };
}
