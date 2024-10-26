{
  flake.homeManagerModules = {
    rosePine = {
      config,
      lib,
      pkgs,
      self,
      ...
    }:
      with lib; let
        cfg = config.rose-pine;
      in {
        options.rose-pine = {
          enable = mkEnableOption "enable rose-pine for all detected programs";
          starship.enable = mkEnableOption "enable rose-pine for starship";
          vesktop.enable = mkEnableOption "enable rose-pine for vencord";
        };

        config = {
          xdg.configFile = mkIf cfg.vesktop.enable {
            "vesktop/themes/rose-pine.theme.css".source = "${self.packages.x86_64-linux.rosePineVesktop}/rose-pine.theme.css";
            "vesktop/themes/rose-pine-moon.theme.css".source = "${self.packages.x86_64-linux.rosePineVesktop}/rose-pine-moon.theme.css";
          };
          programs.starship.settings = mkIf cfg.starship.enable (mkForce {
            format = ''
              $username$directory$git_branch$git_status$fill$c$elixir$elm$golang$haskell$java$julia$nodejs$nim$rust$scala$python
              $time
              [󱞪](fg:iris)
            '';

            palette = "rose-pine";

            palettes.rose-pine = {
              overlay = "#26233a";
              love = "#eb6f92";
              gold = "#f6c177";
              rose = "#ebbcba";
              pine = "#31748f";
              foam = "#9ccfd8";
              iris = "#c4a7e7";
            };
            directory = {
              format = "[](fg:overlay)[ $path ]($style)[](fg:overlay)";
              style = "bg:overlay fg:pine";
              truncation_length = 3;
              truncation_symbol = "…/";
              substitutions = {
                Documents = "󰈙";
                Downloads = " ";
                Music = " ";
                Pictures = " ";
              };
            };
            fill = {
              style = "fg:overlay";
              symbol = " ";
            };
            git_branch = {
              format = "[](fg:overlay)[ $symbol $branch ]($style)[](fg:overlay)";
              style = "bg:overlay fg:foam";
              symbol = "";
            };
            git_status = {
              style = "bg:overlay fg:love";
              format = "[](fg:overlay)[$all_status$ahead_behind]($style)[](fg:overlay)";
              disabled = true;
            };
            time = {
              disabled = false;
              format = "[](fg:overlay)[ $time 󰴈 ]($style)[](fg:overlay)";
              style = "bg:overlay fg:rose";
              time_format = "%I:%M%P";
              use_12hr = true;
            };
            username = {
              disabled = false;
              format = "[](fg:overlay)[ 󰧱 $user ]($style)[](fg:overlay)";
              show_always = true;
              style_root = "bg:overlay fg:iris";
              style_user = "bg:overlay fg:iris";
            };

            # Languages
            c = {
              style = "bg:overlay fg:pine";
              format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
              disabled = false;
              symbol = " ";
            };
            elm = {
              style = "bg:overlay fg:pine";
              format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
              disabled = false;
              symbol = " ";
            };
            golang = {
              style = "bg:overlay fg:pine";
              format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
              disabled = false;
              symbol = " ";
            };
            haskell = {
              style = "bg:overlay fg:pine";
              format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
              disabled = false;
              symbol = " ";
            };
            java = {
              style = "bg:overlay fg:pine";
              format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
              disabled = false;
              symbol = " ";
            };
            julia = {
              style = "bg:overlay fg:pine";
              format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
              disabled = false;
              symbol = " ";
            };
            nodejs = {
              style = "bg:overlay fg:pine";
              format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
              disabled = false;
              symbol = "󰎙 ";
            };
            nim = {
              style = "bg:overlay fg:pine";
              format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
              disabled = false;
              symbol = "󰆥 ";
            };
            rust = {
              style = "bg:overlay fg:pine";
              format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
              disabled = false;
              symbol = "";
            };
            scala = {
              style = "bg:overlay fg:pine";
              format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
              disabled = false;
              symbol = " ";
            };
            python = {
              style = "bg:overlay fg:pine";
              format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
              disabled = false;
              symbol = " ";
            };
          });
          fonts.fontconfig.enable = mkIf cfg.starship.enable true;
          home.packages = mkIf cfg.starship.enable [pkgs.noto-fonts-color-emoji];
        };
      };
  };
}
