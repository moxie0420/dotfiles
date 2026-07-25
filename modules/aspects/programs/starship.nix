{programs, ...}: {
  programs.starship = {
    nixos = let
      rose-pine = {
        base = "#191724";
        foam = "#9ccfd8";
        gold = "#f6c177";
        highlighthigh = "#524f67";
        highlightlow = "#21202e";
        highlightmed = "#403d52";
        iris = "#c4a7e7";
        love = "#eb6f92";
        muted = "#6e6a86";
        overlay = "#26233a";
        pine = "#31748f";
        rose = "#ebbcba";
        subtle = "#908caa";
        surface = "#1f1d2e";
        text = "#e0def4";
      };
    in {
      programs.starship = {
        enable = true;
        presets = ["nerd-font-symbols"];
        settings = let
          disabled = false;
          format = "[$symbol $version]($style)";
        in {
          package = {
            inherit disabled;
            format = "[$symbol$version ]($style)";
          };
          # languages
          c = {
            inherit format disabled;
            style = "bg:overlay fg:foam";
          };
          character = {
            error_symbol = "[](love)";
            success_symbol = "[](pine)";
          };
          directory = {
            format = "[ $path ]($style)[](fg:surface bg:overlay)";
            style = "bg:surface fg:iris";
            substitutions = {
              Documents = "󰈙";
              Downloads = " ";
              Music = " ";
              Pictures = " ";
            };
            truncation_length = 3;
            truncation_symbol = ".../";
          };
          fill.symbol = " ";
          format = ''
            [](fg:overlay)$os$username$hostname$directory$git_branch$git_status[](fg:overlay)$fill$time
            $character[󱞪 ](iris)
          '';
          git_branch = {
            format = "[$symbol$branch ]($style)";
            style = "bg:overlay fg:text";
          };
          git_status = {
            ahead = "[](fg:foam bg:overlay)$count";
            behind = "[](fg:love bg:overlay)$count";
            deleted = "[󰆴 $count ](fg:love bg:overlay)";
            diverged = " ($ahead_count | $behind_count)";
            format = "[$all_status$ahead_behind ]($style)";
            modified = "[󱇧 $count ](fg:rose bg:overlay)";
            renamed = "[󰑕 $count ](fg:pine bg:overlay)";
            staged = "[󰆓 $count ](fg:iris bg:overlay)";
            stashed = "[$$count ](fg:iris bg:overlay)";
            style = "bg:overlay fg:text";
            untracked = "[?$count ](fg:subtle bg:overlay)";
            up_to_date = "";
          };
          hostname = {
            format = "[@](bg:base fg:text)[$hostname ]($style)[](fg:base bg:surface)";
            ssh_only = false;
            style = "bg:base fg:iris";
          };
          nix_shell = {
            inherit disabled;
            format = "via [$symbol(($name))]($style) ";
            heuristic = true;
            symbol = " ";
          };
          nodejs = {
            inherit format disabled;
            style = "fg:foam";
          };
          os = {
            inherit disabled;
            format = "[](fg:surface bg:overlay)[ $symbol ]($style)";
            style = "bg:surface fg:text";
            symbols.NixOS = "";
          };
          palette = "rose-pine";
          palettes = {
            inherit rose-pine;
          };
          right_format = "$all";
          ruby = {
            inherit disabled;
            format = "[$symbol($version)]($style) ";
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
          username = {
            format = "[](fg:base bg:surface)[ $user]($style)";
            show_always = true;
            style_root = "bg:base fg:love";
            style_user = "bg:base fg:pine";
          };
        };
        transientPrompt = {
          enable = true;
          right = ''
            starship module time
          '';
        };
      };
    };
    provides = {
      to-hosts.includes = [programs.starship];
      # to-users.includes = [ programs.starship ];
    };
  };
}
