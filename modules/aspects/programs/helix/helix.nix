{programs, ...}: {
  programs.helix = {
    includes = [
      programs.helix.formatters
      programs.helix.languages
      programs.helix.settings
    ];

    homeManager.programs.helix = {
      enable = true;
      defaultEditor = true;

      languages.language = let
        prettier = name: let
          parser =
            if (name == "jsx" || name == "tsx")
            then "typescript"
            else name;
        in {
          command = "prettier";
          args = ["--parser" parser];
        };
      in [
        {
          name = "nix";
          formatter.command = "alejandra";
          auto-format = true;
        }

        rec {
          name = "css";
          language-servers = ["vscode-css-language-server" "eslint" "emmet-ls"];
          auto-format = true;
          formatter = prettier name;
        }

        rec {
          name = "html";
          language-servers = ["vscode-html-language-server" "eslint"];
          auto-format = true;
          formatter = prettier name;
        }

        rec {
          name = "javascript";
          language-servers = ["typescript-language-server" "eslint"];
          auto-format = true;
          formatter = prettier name;
        }

        rec {
          name = "jsx";
          language-servers = ["typescript-language-server" "eslint"];
          auto-format = true;
          formatter = prettier name;
        }

        rec {
          name = "typescript";
          language-servers = ["typescript-language-server" "eslint"];
          auto-format = true;
          formatter = prettier name;
        }

        rec {
          name = "tsx";
          language-servers = ["typescript-language-server" "eslint"];
          auto-format = true;
          formatter = prettier name;
        }
      ];
    };

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
