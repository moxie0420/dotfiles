{
  programs.starship.nixos = let
    rose-pine = {
      base = "#191724";
      surface = "#1f1d2e";
      overlay = "#26233a";
      muted = "#6e6a86";
      subtle = "#908caa";
      text = "#e0def4";

      love = "#eb6f92";
      gold = "#f6c177";
      rose = "#ebbcba";
      pine = "#31748f";
      foam = "#9ccfd8";
      iris = "#c4a7e7";

      highlightlow = "#21202e";
      highlightmed = "#403d52";
      highlighthigh = "#524f67";
    };
  in {
    programs.starship = {
      enable = true;

      presets = ["nerd-font-symbols"];

      transientPrompt = {
        enable = true;
        right = ''
          starship module time
        '';
      };

      settings = let
        format = "[$symbol $version]($style)";
        disabled = false;
      in {
        palette = "rose-pine";
        palettes = {
          inherit rose-pine;
        };
        format = ''
          [](fg:overlay)$os$username$hostname$directory$git_branch$git_status[](fg:overlay)$fill$time
          $character[󱞪 ](iris)
        '';
        right_format = "$all";

        fill.symbol = " ";

        package = {
          inherit disabled;
          format = "[$symbol$version ]($style)";
        };

        character = {
          success_symbol = "[](pine)";
          error_symbol = "[](love)";
        };

        nix_shell = {
          inherit disabled;
          format = "via [$symbol(($name))]($style) ";
          symbol = " ";
          heuristic = true;
        };

        os = {
          inherit disabled;
          format = "[](fg:surface bg:overlay)[ $symbol ]($style)";
          style = "bg:surface fg:text";
          symbols.NixOS = "";
        };

        username = {
          format = "[](fg:base bg:surface)[ $user]($style)";
          show_always = true;
          style_user = "bg:base fg:pine";
          style_root = "bg:base fg:love";
        };

        hostname = {
          ssh_only = false;
          format = "[@](bg:base fg:text)[$hostname ]($style)[](fg:base bg:surface)";
          style = "bg:base fg:iris";
        };

        directory = {
          format = "[ $path ]($style)[](fg:surface bg:overlay)";
          style = "bg:surface fg:iris";
          truncation_length = 3;
          truncation_symbol = ".../";
          substitutions = {
            Documents = "󰈙";
            Downloads = " ";
            Music = " ";
            Pictures = " ";
          };
        };

        git_branch = {
          format = "[$symbol$branch ]($style)";
          style = "bg:overlay fg:text";
        };

        git_status = {
          style = "bg:overlay fg:text";
          format = "[$all_status$ahead_behind ]($style)";

          ahead = "[](fg:foam bg:overlay)$count";
          diverged = " ($ahead_count | $behind_count)";
          behind = "[](fg:love bg:overlay)$count";
          up_to_date = "";

          untracked = "[?$count ](fg:subtle bg:overlay)";
          stashed = "[$$count ](fg:iris bg:overlay)";

          modified = "[󱇧 $count ](fg:rose bg:overlay)";
          staged = "[󰆓 $count ](fg:iris bg:overlay)";
          renamed = "[󰑕 $count ](fg:pine bg:overlay)";
          deleted = "[󰆴 $count ](fg:love bg:overlay)";
        };

        # right modules

        time = let
          l1 = "(fg:overlay)";
          l2 = "(fg:base bg:overlay)";
          l3 = "[ 󰉊 ](fg:rose bg:base)";
          ls = "[]";
          rs = "[]";
        in {
          inherit disabled;
          format = "${ls + l1}${ls + l2}[ $time ]($style)${l3}${rs + l2}${rs + l1}";
          style = "bg:base fg:pine";
          time_format = "%H:%M %m/%d/%Y";
        };

        # languages

        c = {
          inherit format disabled;
          style = "bg:overlay fg:foam";
        };

        nodejs = {
          inherit format disabled;
          style = "fg:foam";
        };

        ruby = {
          inherit disabled;
          format = "[$symbol($version)]($style) ";
        };
      };
    };
  };
}
