{
  programs.helix.settings = {
    homeManager.programs.helix.settings = {
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
  };
}
