{inputs, ...}: let
  settings = {
    attrs = {
      blank-lines = 1;
      blank-lines-mode = "multiline";
      merge = true;
      sort = true;
    };

    formatter = "alejandra";
    lets.sort = true;
    preset = "nixos-module";
    top-level-blank-lines = 1;
  };
in {
  perSystem = {
    treefmt.programs.pedantix = {
      inherit settings;
      enable = true;
    };
  };

  programs.pedantix = {
    homeManager = {
      imports = [
        inputs.pedantix.homeModules.default
      ];

      programs.pedantix = {
        inherit settings;
        enable = true;
      };
    };
  };
}
