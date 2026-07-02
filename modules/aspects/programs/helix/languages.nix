{programs, ...}: {
  programs.helix.languages = {
    includes = with programs.helix.languages; [
      fish
      markdown
      nix
    ];

    osDev.includes = with programs.helix.languages; [
      clang
      csharp
    ];

    webDev.includes = with programs.helix.languages; [
      css
      emmet
      eslint
      html
      json
      toml
      typescript
    ];

    # C/C++
    clang.homeManager = {pkgs, ...}: {
      programs.helix.extraPackages = builtins.attrValues {
        inherit (pkgs) clang-tools;
      };
    };

    csharp.homeManager = {pkgs, ...}: {
      programs.helix.extraPackages = builtins.attrValues {
        inherit (pkgs) omnisharp-roslyn;
      };
    };

    css.homeManager = {pkgs, ...}: {
      programs.helix = {
        extraPackages = builtins.attrValues {
          inherit (pkgs) vscode-langservers-extracted;
        };

        languages.language-server.vscode-css-language-server = {
          config = {
            css.validate.enable = true;
            scss.validate.enable = true;
            less.validate.enable = true;
            provideFormatter = true;
          };
        };
      };
    };

    # emmet intergration for webdev
    emmet.homeManager = {pkgs, ...}: {
      programs.helix = {
        extraPackages = builtins.attrValues {
          inherit (pkgs) emmet-language-server;
        };

        languages.language-server.emmet-ls = {
          command = "emmet-ls";
          args = ["--stdio"];
        };
      };
    };

    # eslint in all of its glory
    eslint.homeManager = {pkgs, ...}: {
      programs.helix = {
        extraPackages = builtins.attrValues {
          inherit (pkgs) vscode-langservers-extracted;
        };

        languages.language-server.eslint = {
          command = "vscode-eslint-language-server";
          args = ["--stdio"];
          config = {
            codeActionsOnSave = {
              mode = "all";
              "source.fixAll.eslint" = true;
            };
            format.enable = true;
            nodePath = "";
            quiet = false;
            rulesCustomizations = [];
            run = "onType";
            validate = "on";
            experimental = {};
            problems.shortenToSingleLine = false;

            codeAction = {
              disableRuleComment = {
                enable = true;
                location = "separateLine";
              };
              showDocumentation.enable = false;
            };
          };
        };
      };
    };

    # fish shell
    fish.homeManager = {pkgs, ...}: {
      programs.helix.extraPackages = builtins.attrValues {
        inherit (pkgs) fish-lsp;
      };
    };

    # html
    html.homeManager = {pkgs, ...}: {
      programs.helix = {
        extraPackages = builtins.attrValues {
          inherit (pkgs) vscode-langservers-extracted;
        };
      };
    };

    # Json
    json.homeManager = {pkgs, ...}: {
      programs.helix = {
        extraPackages = builtins.attrValues {
          inherit (pkgs) vscode-langservers-extracted;
        };

        languages.language-server.vscode-json-language-server.config = {
          json = {
            validate.enable = true;
            format.enable = true;
          };
          provideFormatter = true;
        };
      };
    };

    # markdown
    markdown.homeManager = {pkgs, ...}: {
      programs.helix.extraPackages = builtins.attrValues {
        inherit (pkgs) markdown-oxide marksman;
      };
    };

    # nixlang
    nix.homeManager = {pkgs, ...}: {
      programs.helix = {
        extraPackages = builtins.attrValues {
          inherit (pkgs) nil nixd;
        };

        languages.language-server = {
          nil.config.nix.flake.autoEvalInputs = true;

          nixd = {
            command = "nixd";
            config.options = {
              expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.<name>.options.home-manager.users.type.getSubOptions []";
            };
          };
        };
      };
    };

    toml.homeManager = {pkgs, ...}: {
      programs.helix.extraPackages = builtins.attrValues {
        inherit (pkgs) taplo tombi;
      };
    };

    # .ts & .tsx
    typescript.homeManager = {pkgs, ...}: {
      programs.helix.extraPackages = builtins.attrValues {
        inherit (pkgs) typescript-language-server;
      };
    };
  };
}
