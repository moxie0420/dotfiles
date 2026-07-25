{programs, ...}: {
  programs.helix.formatters = {
    includes = with programs.helix.formatters; [
      prettier
    ];

    prettier.homeManager = {pkgs, ...}: {
      programs.helix.extraPackages = builtins.attrValues {
        inherit (pkgs) prettier;
      };
    };
  };
}
