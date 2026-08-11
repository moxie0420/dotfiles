{
  programs.helix.settings = {
    homeManager.programs.helix.settings = {
      editor = {
        bufferline = "multiple";

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        end-of-line-diagnostics = "hint";

        file-picker = {
          hidden = false;
        };

        indent-guides.render = true;

        inline-diagnostics = {
          cursor-line = "error";
          other-lines = "disable";
        };

        line-number = "relative";

        lsp = {
          auto-signature-help = false;
          display-progress-messages = true;
        };

        statusline = {
          center = ["file-name"];

          left = [
            "mode"
            "version-control"
          ];

          mode = {
            insert = "Insert";
            normal = "Normal";
            select = "Select";
          };

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
        };
      };
    };
  };
}
