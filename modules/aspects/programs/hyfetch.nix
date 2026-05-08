{
  programs.hyfetch.homeManager = {
    programs = {
      fastfetch = {
        enable = true;
        settings = let
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

          text = "{#${rose-pine.text}}";

          gold = "{#${rose-pine.gold}}";
          rose = "{#${rose-pine.rose}}";
          pine = "{#${rose-pine.pine}}";
          foam = "{#${rose-pine.foam}}";
          iris = "{#${rose-pine.iris}}";

          border = "{#${rose-pine.highlighthigh}}";
        in {
          display = {
            separator = " -> ";
            constants = [
              "──────────────────────────────"
            ];
          };

          modules = let
            sectionTop = name: {
              type = "custom";
              format = "${border}╭{$1}${text}${name}${border}{$1}╮";
            };

            sectionBottom = {
              type = "custom";
              format = "╰{$1}────────{$1}╯";
              outputColor = "#524f67";
            };
          in [
            (sectionTop "Hardware")

            {
              type = "swap";
              key = "${iris}  Swap";
              percent = {
                type = 3;
                green = 30;
                yellow = 70;
              };
            }

            {
              type = "memory";
              key = "${iris}  RAM ";
              percent = {
                type = 3;
                green = 30;
                yellow = 70;
              };
            }

            {
              type = "cpu";
              key = "${iris}  CPU ";
            }

            {
              type = "gpu";
              key = "${iris}  GPU ";
              format = "{2}, {3}";
            }

            sectionBottom
            (sectionTop "Software")

            {
              type = "os";
              key = "${foam}  OS    ";
              format = "{name} {version}";
            }

            {
              type = "wm";
              key = "${foam}  WM    ";
            }

            {
              type = "de";
              key = "${foam}  DE    ";
            }

            {
              type = "kernel";
              key = "${foam}  Kernel";
            }

            sectionBottom
            (sectionTop "Theming${border}─")

            {
              type = "packages";
              key = "${pine}  Packages     ";
              combined = true;
            }

            {
              type = "shell";
              key = "${pine}  Shell        ";
            }

            {
              type = "wmtheme";
              key = "${pine}  Theme        ";
            }

            {
              type = "terminal";
              key = "${pine}  Terminal     ";
              format = "{1}";
            }

            {
              type = "terminalfont";
              key = "${pine}  Terminal Font";
              format = "{/name}{-}{/}{name}{?size} {size}{?}";
            }

            sectionBottom
            (sectionTop "Disks${border}───")

            {
              type = "disk";
              folders = "/";
              key = "${rose}  Nix Root ";
              percent = {
                type = 3;
                green = 30;
                yellow = 70;
              };
            }

            {
              type = "disk";
              folders = "/mnt/the_store";
              key = "${rose}  The Store";
              percent = {
                type = 3;
                green = 30;
                yellow = 70;
              };
            }

            sectionBottom
            (sectionTop "${border}────────")

            {
              type = "command";
              key = "${gold}  NixUwU's age ";
              text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
            }

            {
              type = "uptime";
              key = "${gold}  Uptime       ";
            }

            sectionBottom
          ];
        };
      };

      hyfetch = {
        enable = true;
        settings = {
          backend = "fastfetch";
          pride_month_disable = false;
          preset = "transgender";
          mode = "rgb";
          color_align = {
            mode = "horizontal";
          };
        };
      };
    };
  };
}
