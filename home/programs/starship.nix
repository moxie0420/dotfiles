{
  programs.starship = {
    enable = true;

    settings = {
      palette = "rose-pine";
      palettes.rose-pine = {
        base = "#191724";
        surface = "#1f1d2e";
        overlay = "#26233a";
        subtle = "#908caa";
        love = "#eb6f92";
        gold = "#f6c177";
        rose = "#ebbcba";
        pine = "#31748f";
        foam = "#9ccfd8";
        iris = "#c4a7e7";
        text = "#e0def4";
      };

      format = ''
        [](fg:overlay)$os$username$directory$git_branch$git_status[](fg:overlay)$fill[](fg:overlay)[](fg:base bg:overlay)$time[](fg:base bg:overlay)[](fg:overlay)
        $character[󱞪 ](iris)
      '';
      right_format = ''
        $all
      '';

      fill = {
        symbol = " ";
      };

      character = {
        success_symbol = "[](pine)";
        error_symbol = "[](love)";
      };

      ruby = {
        format = "[$symbol($version)]($style) ";
        symbol = " ";
      };

      nix_shell = {
        format = "via [$symbol(\($name\))]($style) ";
        symbol = " ";
        heuristic = true;
      };

      os = {
        format = "[](fg:surface bg:overlay)[ $symbol ]($style)";
        style = "bg:surface fg:text";
        disabled = false;
        symbols = {
          NixOS = "";
        };
      };

      username = {
        format = "[](fg:base bg:surface)[ $user ]($style)[](fg:base bg:surface)";
        show_always = true;
        style_user = "bg:base fg:pine";
        style_root = "bg:base fg:love";
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
        symbol = "  ";
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

      time = {
        disabled = false;
        format = "[ $time ]($style)[ 󰉊 ](fg:rose bg:base)";
        style = "bg:base fg:pine";
        time_format = "%H:%M %m/%d/%Y";
        use_12hr = false;
      };

      # languages

      c = {
        style = "bg:overlay fg:foam";
        format = "[$symbol $version]($style)";
        disabled = false;
        symbol = "";
      };

      haskell = {
        style = "bg:overlay fg:iris";
        format = "[$symbol $version]($style)";
        disabled = false;
        symbol = "";
      };

      java = {
        style = "bg:surface fg:love";
        format = "[$symbol $version]($style)";
        disabled = false;
        symbol = " ";
      };

      nodejs = {
        style = "bg:overlay fg:foam";
        format = "[$symbol $version]($style)";
        disabled = false;
        symbol = "";
      };

      rust = {
        style = "bg:overlay fg:rose";
        format = "[$symbol $version]($style)";
        disabled = false;
        symbol = "";
      };

      python = {
        style = "bg:overlay fg:gold";
        format = "[$symbol $version]($style)";
        disabled = false;
        symbol = "";
      };
    };
  };
}
