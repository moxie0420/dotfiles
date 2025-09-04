{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      nil
      typescript-language-server
      typescript
      tailwindcss-language-server
      vscode-langservers-extracted
      prettierd
      alejandra
      ruff
      pyright
      pylyzer
      rust-analyzer
      rubyPackages.solargraph
      rubyPackages_3_4.ruby-lsp
    ];

    settings = {
      theme = "base16_transparent";
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
        nil.command = "${pkgs.nil}/bin/nil";

        # tsx, ts, css, html
        eslint = {
          command = "vscode-eslint-language-server";
          args = ["--stdio"];
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
              source.fixAll.eslint = true;
            };
            format.enable = true;
            nodePath = "";
            quiet = false;
            rulesCustomizations = [];
            run = "onType";
            validate = "on";
            experimental = {};
            problems.shortenToSingleLine = false;
          };
        };

        vscode-json-language-server = {
          config = {
            json = {
              validate.enable = true;
              format.enable = true;
            };
            provideFormatter = true;
          };
        };

        vscode-css-language-server = {
          config = {
            css.validate.enable = true;
            scss.validate.enable = true;
            less.validate.enable = true;
            provideFormatter = true;
          };
        };

        tailwindcss-ls = {
          command = "tailwindcss-language-server";
          args = ["--stdio"];
        };

        pyright.config.python.analysis.typeCheckingMode = "basic";

        ruff = {
          command = "ruff";
          args = ["server"];
        };

        pylyzer = {
          command = "pylyzer";
          args = ["--server"];
        };

        rust-analyzer.config = {
          check.command = "clippy";
        };
      };

      language = [
        {
          name = "nix";
          formatter = {
            command = "alejandra";
          };
          auto-format = true;
        }
        {
          name = "python";
          language-servers = ["pyright" "ruff" "pylyzer"];
          formatter = {
            command = "ruff";
            args = ["format" "--line-length" "88" "-"];
          };
          auto-format = true;
        }

        {
          name = "html";
          language-servers = ["vscode-html-language-server" "emmet-ls"];
          auto-format = true;
          formatter = {
            command = "prettierd";
            args = [".html"];
          };
        }
        {
          name = "css";
          language-servers = ["vscode-css-language-server" "emmet-ls"];
          auto-format = true;
          formatter = {
            command = "prettierd";
            args = [".css"];
          };
        }

        {
          name = "tsx";
          language-servers = ["typescript-language-server" "eslint" "emmet-ls"];
          auto-format = true;
          formatter = {
            command = "prettierd";
            args = [".tsx"];
          };
        }
        {
          name = "typescript";
          language-servers = ["typescript-language-server" "eslint" "emmet-l"];
          auto-format = true;
          formatter = {
            command = "prettierd";
            args = [".ts"];
          };
        }

        {
          name = "json";
          auto-format = true;
        }

        {
          name = "ruby";
          file-types = ["rb"];
          auto-format = true;
          formatter = {
            command = "bundle";
            args = ["exec" "stree" "format"];
          };
        }

        {
          name = "erb";
          file-types = ["erb"];
          auto-format = true;
          grammar = "embedded-template";
          language-servers = ["ruby-lsp"];
        }
      ];
    };
  };
}
