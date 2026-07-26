{programs, ...}: {
  programs.hyfetch = {
    homeManager = {
      programs = {
        fastfetch = {
          enable = true;

          settings = let
            border = "{#${rose-pine.highlighthigh}}";
            foam = "{#${rose-pine.foam}}";
            gold = "{#${rose-pine.gold}}";
            iris = "{#${rose-pine.iris}}";
            pine = "{#${rose-pine.pine}}";
            rose = "{#${rose-pine.rose}}";
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
            text = "{#${rose-pine.text}}";
          in {
            display = {
              constants = [
                "──────────────────────────────"
              ];

              separator = " -> ";
            };

            modules = let
              sectionBottom = {
                format = "╰{$1}────────{$1}╯";
                outputColor = "#524f67";
                type = "custom";
              };
              sectionTop = name: {
                format = "${border}╭{$1}${text}${name}${border}{$1}╮";
                type = "custom";
              };
            in [
              (sectionTop "Hardware")

              {
                key = "${iris}  Swap";

                percent = {
                  green = 30;
                  type = 3;
                  yellow = 70;
                };

                type = "swap";
              }

              {
                key = "${iris}  RAM ";

                percent = {
                  green = 30;
                  type = 3;
                  yellow = 70;
                };

                type = "memory";
              }

              {
                key = "${iris}  CPU ";
                type = "cpu";
              }

              {
                format = "{2}, {3}";
                key = "${iris}  GPU ";
                type = "gpu";
              }

              sectionBottom
              (sectionTop "Software")

              {
                format = "{name} {version}";
                key = "${foam}  OS    ";
                type = "os";
              }

              {
                key = "${foam}  WM    ";
                type = "wm";
              }

              {
                key = "${foam}  DE    ";
                type = "de";
              }

              {
                key = "${foam}  Kernel";
                type = "kernel";
              }

              sectionBottom
              (sectionTop "Theming${border}─")

              {
                combined = true;
                key = "${pine}  Packages     ";
                type = "packages";
              }

              {
                key = "${pine}  Shell        ";
                type = "shell";
              }

              {
                key = "${pine}  Theme        ";
                type = "wmtheme";
              }

              {
                format = "{1}";
                key = "${pine}  Terminal     ";
                type = "terminal";
              }

              {
                format = "{/name}{-}{/}{name}{?size} {size}{?}";
                key = "${pine}  Terminal Font";
                type = "terminalfont";
              }

              sectionBottom
              (sectionTop "Disks${border}───")

              {
                folders = "/";
                key = "${rose}  Nix Root ";

                percent = {
                  green = 30;
                  type = 3;
                  yellow = 70;
                };

                type = "disk";
              }

              {
                folders = "/mnt/the_store";
                key = "${rose}  The Store";

                percent = {
                  green = 30;
                  type = 3;
                  yellow = 70;
                };

                type = "disk";
              }

              sectionBottom
              (sectionTop "${border}────────")

              {
                key = "${gold}  NixUwU's age ";
                text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
                type = "command";
              }

              {
                key = "${gold}  Uptime       ";
                type = "uptime";
              }

              sectionBottom
            ];
          };
        };

        hyfetch = {
          enable = true;

          settings = {
            backend = "fastfetch";

            color_align = {
              mode = "horizontal";
            };

            mode = "rgb";
            preset = "transgender";
            pride_month_disable = false;
          };
        };
      };
    };

    nixos = {pkgs, ...}: {
      environment.systemPackages = [
        pkgs.fastfetch
        pkgs.hyfetch
      ];
    };

    provides = {
      to-hosts.includes = [programs.hyfetch];
      to-users.includes = [programs.hyfetch];
    };
  };
}
