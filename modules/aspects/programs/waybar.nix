{programs, ...}: {
  programs.waybar = {
    homeManager = {pkgs, ...}: {
      home.packages = builtins.attrValues {
        inherit (pkgs) cava;
      };

      programs.waybar = {
        enable = true;

        settings = let
          barDefaults = {
            height = 38;
            layer = "top";
            spacing = 4;
            width = 1920;
          };
          cava = {
            actions = {
              on-click-right = "mode";
            };

            autosens = 1;
            bar_delimiter = 0;
            bars = 20;

            format-icons = [
              "▁"
              "▂"
              "▃"
              "▄"
              "▅"
              "▆"
              "▇"
              "█"
            ];

            framerate = 60;
            hide_on_silence = false;
            higher_cutoff_freq = 20000;
            input_delay = 2;
            lower_cutoff_freq = 20;
            method = "pipewire";
            monstercat = true;
            noise_reduction = 0.77;
            reverse = false;
            sensitivity = 1;
            source = "auto";
            stereo = true;
            waves = true;
          };
          clock = {
            format = "{:%H:%M:%S}";
            format-alt = "{:%Y-%m-%d}";
            interval = 1;
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };
          cpu = {
            format = "{usage}% ";
            tooltip = false;
          };
          idle_inhibitor = {
            format = "{icon} ";

            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          literals = {
            top = "top";
          };
          memory.format = "{}% ";
          network = {
            format-alt = "{ifname}: {ipaddr}/{cidr}";
            format-disconnected = "Disconnected ⚠";
            format-ethernet = "{ipaddr}/{cidr} 󰊗";
            format-linked = "{ifname} (No IP) 󰊗";
            # interface = "wlp2*"; # (Optional) To force the use of this interface
            format-wifi = "{essid} ({signalStrength}%) ";
            tooltip-format = "{ifname} via {gwaddr} 󰊗";
          };
          power-profiles-daemon = {
            format = "{icon}";

            format-icons = {
              balanced = "";
              default = "";
              performance = "";
              power-saver = "";
            };

            tooltip = true;
            tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          };
          privacy = {
            ignore = [
              {
                name = "cava";
                type = "audio-in";
              }
            ];
          };
          tempurature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";

            format-icons = [
              "󰉬 "
              " "
              "󰉪 "
            ];

            thermal-zone = 1;
          };
          wireplumber = {
            format = "{volume}% {icon} ";

            format-icons = [
              ""
              ""
              ""
            ];

            format-muted = "";
            on-click = "pwvucontrol";
          };
        in {
          mainBar =
            barDefaults
            // {
              inherit
                cava
                clock
                cpu
                idle_inhibitor
                memory
                network
                power-profiles-daemon
                privacy
                tempurature
                wireplumber
                ;

              "custom/power" = {
                format = "";
                on-click = "shutdown now";
                tooltip = false;
              };

              # custom modules
              "custom/quit" = {
                format = "󰗼";
                on-click = "niri msg exit";
                tooltip = false;
              };

              "custom/reboot" = {
                format = "󰜉";
                on-click = "reboot";
                tooltip = false;
              };

              "group/group-hardware" = {
                drawer = {
                  children-class = "not-cpu";
                  transition-duration = 500;
                };

                modules = [
                  "cpu"
                  "memory"
                  "network"
                  "temperature"
                ];

                orientation = "inherit";
              };

              "group/group-power" = {
                drawer = {
                  children-class = "not-power";
                  transition-duration = 500;
                };

                modules = [
                  "custom/power" # First element is the "group leader" and won't ever be hidden
                  "custom/quit"
                  "custom/reboot"
                ];

                orientation = "inherit";
              };

              modules-center = [
                "niri/window"
              ];

              modules-left = [
                "cava"
                "niri/workspaces"
                "privacy"
              ];

              modules-right = [
                "idle_inhibitor"
                "wireplumber"
                "power-profiles-daemon"
                "group/group-hardware"
                "systemd-failed-units"
                "tray"
                "clock"
                "group/group-power"
              ];

              position = literals.top;
            };
        };

        style = ''
          window#waybar {
            background: none;
          }

          .modules-left,
          .modules-right {
            background: @theme_bg_color;
            padding: 0.175rem 0.3rem 0.25rem;
          }

          .modules-left {
            border-radius: 0 0 1rem 0;
          }

          .modules-right {
            border-radius: 0 0 0 1rem;
          }

          #custom-power,
          #custom-quit,
          #custom-reboot {
            padding: 0 5px;
          }

          #workspaces button {
            margin: 0.125rem;
          }

          #clock,
          #cpu,
          #idle_inhibitor,
          #window,
          #wireplumber,
          #memory,
          #network,
          #power-profiles-daemon,
          #privacy,
          #tempurature {
            border-radius: 0.5rem;
          }

          #idle_inhibitor {
            padding: 0 10px;
          }

          #power-profiles-daemon {
            padding: 0 10px;
            background: @warning_color;
          }

          #power-profiles-daemon.performance {
            background: @error_color;
          }

          #group-power.module {
           margin: 0.25rem;
            background: @theme_fg_color;
          }
        '';
      };
    };

    nixos.programs.waybar.enable = true;

    provides = {
      to-hosts.includes = [programs.waybar];
      to-users.includes = [programs.waybar];
    };
  };
}
