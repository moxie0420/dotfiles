{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      gcc
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

        herb = {
          command = "herb-language-server";
          args = ["--stdio"];
        };
      };

      grammar = [
        {
          name = "less";
          source = {
            git = "https://github.com/jimliang/tree-sitter-less";
            rev = "945f52c94250309073a96bbfbc5bcd57ff2bde49";
          };
        }
        {
          name = "erb";
          source = {
            git = "https://github.com/tree-sitter/tree-sitter-embedded-template.git";
            rev = "c70c1de07dedd532089c0c90835c8ed9fa694f5c";
          };
        }
      ];

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
          name = "less";
          grammar = "less";
          file-types = ["less"];
          scope = "source.less";
          language-servers = ["vscode-css-language-server" "emmet-ls"];
          formatter = {
            command = "prettierd";
            args = [".less"];
          };
        }

        {
          name = "ruby";
          injection-regex = "ruby";
          file-types = ["rb" "rake"];
          shebangs = ["ruby"];
          language-servers = ["solargraph"];
          auto-format = true;
          formatter = {
            command = "bundle";
            args = ["exec" "stree" "format"];
          };
        }

        {
          name = "erb";
          grammar = "erb";
          scope = "source.erb";
          file-types = ["erb"];
          language-servers = ["herb"];
        }
      ];
    };
  };
}
