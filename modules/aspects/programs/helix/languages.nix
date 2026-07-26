{
  programs,
  self,
  ...
}: {
  programs.helix.languages = {
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
            less.validate.enable = true;
            provideFormatter = true;
            scss.validate.enable = true;
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
          args = ["--stdio"];
          command = "emmet-ls";
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
          config = {
            codeAction = {
              disableRuleComment = {
                enable = true;
                location = "separateLine";
              };

              showDocumentation.enable = false;
            };

            codeActionsOnSave = {
              mode = "all";
              "source.fixAll.eslint" = true;
            };

            experimental = {};
            format.enable = true;
            nodePath = "";
            problems.shortenToSingleLine = false;
            quiet = false;
            rulesCustomizations = [];
            run = "onType";
            validate = "on";
          };

          args = ["--stdio"];
          command = "vscode-eslint-language-server";
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

    includes = with programs.helix.languages; [
      fish
      markdown
      nix
    ];

    # Json
    json.homeManager = {pkgs, ...}: {
      programs.helix = {
        extraPackages = builtins.attrValues {
          inherit (pkgs) vscode-langservers-extracted;
        };

        languages.language-server.vscode-json-language-server.config = {
          json = {
            format.enable = true;
            validate.enable = true;
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
    nix = {host, ...}: {
      homeManager = {pkgs, ...}: {
        programs.helix = {
          extraPackages = builtins.attrValues {
            inherit (pkgs) nil nixd;
          };

          languages.language-server = {
            nil.config = {
              nix.flake = {
                autoArchive = true;
                autoEvalInputs = true;
              };
            };

            nixd = {
              config.options = {
                # extra flakes
                flake-parts.expr = "(builtins.getFlake \"${self}\").debug.options";
                flake-parts2.expr = "(builtins.getFlake \"${self}\").currentSystem.options";
                home-manager.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${host.name}.options.home-manager.users.type.getSubOptions []";
                nixos.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${host.name}.options";
              };

              command = "nixd";
            };
          };
        };
      };
    };

    osDev.includes = with programs.helix.languages; [
      clang
      csharp
    ];

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

    webDev.includes = with programs.helix.languages; [
      css
      emmet
      eslint
      html
      json
      toml
      typescript
    ];
  };
}
