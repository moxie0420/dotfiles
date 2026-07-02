{
  lib,
  programs,
  ...
}: {
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

        laqnguages.language.nix = {
          formatter.command = "alejandra";
          auto-format = true;
        };
      };
    };

    prettier.homeManager = {pkgs, ...}: {
      programs.helix = {
        extraPackages = builtins.attrValues {
          inherit (pkgs) prettier;
        };

        languages.language =
          lib.genAttrs [
            "css"
            "html"
            "javascript"
            "jsx"
            "typescript"
            "tsx"
            "json"
          ] (name: let
            parser =
              if (name == "jsx" || name == "tsx")
              then "typescript"
              else name;
          in {
            formatter = {
              command = "prettier";
              args = ["--parser" parser];
            };
            auto-format = true;
          });
      };
    };
  };
}
