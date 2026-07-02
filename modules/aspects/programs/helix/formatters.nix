{programs, ...}: {
  programs.helix.formatters = {
    includes = with programs.helix.formatters; [
      alejandra
      prettier
    ];

    alejandra.homeManager = {pkgs, ...}: {
      programs.helix = {
        extraPackages = builtins.attrValues {
          inherit (pkgs) alejandra;
        };
      };
    };

    prettier.homeManager = {pkgs, ...}: {
      programs.helix.extraPackages = builtins.attrValues {
        inherit (pkgs) prettier;
      };
    };
  };
}
