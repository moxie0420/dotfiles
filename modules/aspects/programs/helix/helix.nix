{
  lib,
  programs,
  ...
}: {
  programs.helix = {
    homeManager = {pkgs, ...}: {
      programs.helix = {
        enable = true;
        defaultEditor = true;

        languages.language = let
          prettier = name: let
            parser =
              if (name == "jsx" || name == "tsx")
              then "typescript"
              else name;
          in {
            args = [
              "--parser"
              parser
            ];
            command = "prettier";
          };
        in [
          {
            auto-format = true;
            formatter.command = "${lib.getExe pkgs.pedantix-wrapped}";
            name = "nix";
          }

          rec {
            auto-format = true;
            formatter = prettier name;
            language-servers = [
              "vscode-css-language-server"
              "eslint"
              "emmet-ls"
            ];
            name = "css";
          }

          rec {
            auto-format = true;
            formatter = prettier name;
            language-servers = [
              "vscode-html-language-server"
              "eslint"
            ];
            name = "html";
          }

          rec {
            auto-format = true;
            formatter = prettier name;
            language-servers = [
              "typescript-language-server"
              "eslint"
            ];
            name = "javascript";
          }

          rec {
            auto-format = true;
            formatter = prettier name;
            language-servers = [
              "typescript-language-server"
              "eslint"
            ];
            name = "jsx";
          }

          rec {
            auto-format = true;
            formatter = prettier name;
            language-servers = [
              "typescript-language-server"
              "eslint"
            ];
            name = "typescript";
          }

          rec {
            auto-format = true;
            formatter = prettier name;
            language-servers = [
              "typescript-language-server"
              "eslint"
            ];
            name = "tsx";
          }
        ];
      };
    };

    includes = [
      programs.helix.formatters
      programs.helix.languages
      programs.helix.settings
    ];

    nixos = {pkgs, ...}: {
      environment = {
        systemPackages = builtins.attrValues {
          inherit (pkgs) helix;
        };
        variables.EDITOR = "hx";
      };
    };
  };
}
