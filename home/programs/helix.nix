{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      clang-tools
      gcc
      nil
      typescript-language-server
      vscode-langservers-extracted
      kdePackages.qtdeclarative
    ];

    themes = {
      ui.menu = "none";
    };

    settings = {
      editor = {
        bufferline = "multiple";
        line-number = "relative";
        end-of-line-diagnostics = "hint";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker = {
          hidden = false;
        };
        lsp = {
          display-progress-messages = true;
          auto-signature-help = false;
        };
        statusline = {
          left = ["mode" "version-control"];
          center = ["file-name"];
          right = [
            "spinner"
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
          separator = "│";
          mode = {
            normal = "Normal";
            insert = "Insert";
            select = "Select";
          };
        };
        inline-diagnostics = {
          "cursor-line" = "error";
          "other-lines" = "disable";
        };
      };
    };
    languages = {
      language-server = {
        # nix
        nil.config = {
          nix.flake.autoEvalInputs = true;
        };

        # Web Dev
        deno = {
          command = "deno";
          args = ["lsp"];
        };

        emmet-ls = {
          command = "emmet-ls";
          args = ["--stdio"];
        };

        eslint = {
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

        vscode-json-language-server.config = {
          json = {
            validate.enable = true;
            format.enable = true;
          };
          provideFormatter = true;
        };

        vscode-css-language-server = {
          config = {
            css.validate.enable = true;
            scss.validate.enable = true;
            less.validate.enable = true;
            provideFormatter = true;
          };
        };
      };

      language = [
        {
          name = "nix";
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
          auto-format = true;
        }

        # Webdev
        {
          name = "typescript";
          language-servers = ["typescript-language-server" "eslint" "emmet-ls"];
          formatter = {
            command = "prettier";
            args = ["--parser" "typescript"];
          };
          auto-format = true;
        }

        {
          name = "tsx";
          language-servers = ["typescript-language-server" "eslint" "emmet-ls"];
          formatter = {
            command = "prettier";
            args = ["--parser" "typescript"];
          };
          auto-format = true;
        }

        {
          name = "javascript";
          language-servers = ["typescript-language-server" "eslint" "emmet-ls"];
          formatter = {
            command = "prettier";
            args = ["--parser" "typescript"];
          };
          auto-format = true;
        }
        {
          name = "jsx";
          language-servers = ["typescript-language-server" "eslint" "emmet-ls"];
          formatter = {
            command = "prettier";
            args = ["--parser" "typescript"];
          };
          auto-format = true;
        }
        {
          name = "json";
          formatter = {
            command = "prettier";
            args = ["--parser" "json"];
          };
          auto-format = true;
        }
        {
          name = "html";
          language-servers = ["vscode-html-language-server" "emmet-ls"];
          formatter = {
            command = "prettier";
            args = ["--parser" "html"];
          };
          auto-format = true;
        }
        {
          name = "css";
          language-servers = ["vscode-css-language-server" "emmet-ls"];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = ["--parser" "css"];
          };
        }
      ];
    };
  };
}
