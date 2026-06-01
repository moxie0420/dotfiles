{lib, ...}: {
  desktop.waybar = {
    nixos.programs.waybar.enable = true;
    homeManager = {pkgs, ...}: {
      home.packages = builtins.attrValues {
        inherit (pkgs) cava;
      };

      stylix.targets.waybar = {
        enableCenterBackColors = true;
        enableLeftBackColors = true;
        enableRightBackColors = true;
      };

      programs.waybar = {
        enable = true;

        style = lib.mkAfter ''
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
            background: @base07;
          }

          #power-profiles-daemon.performance {
            background: @base08;
          }

          #group-power.module {
           margin: 0.25rem;
            background: @base07;
          }
        '';

        settings = let
          literals = {
            top = "top";
          };

          barDefaults = {
            layer = "top";
            spacing = 4;
            height = 38;
            width = 1440;
          };

          cava = {
            framerate = 60;
            autosens = 1;
            sensitivity = 1;
            bars = 20;
            lower_cutoff_freq = 20;
            higher_cutoff_freq = 20000;
            hide_on_silence = false;
            method = "pipewire";
            source = "auto";
            stereo = true;
            reverse = false;
            bar_delimiter = 0;
            monstercat = true;
            waves = true;
            noise_reduction = 0.77;
            input_delay = 2;
            format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
            actions = {
              on-click-right = "mode";
            };
          };

          clock = {
            interval = 1;
            format = "{:%H:%M:%S}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
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

          memory.format = "{}% ";

          network = {
            # interface = "wlp2*"; # (Optional) To force the use of this interface
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} 󰊗";
            tooltip-format = "{ifname} via {gwaddr} 󰊗";
            format-linked = "{ifname} (No IP) 󰊗";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };

          power-profiles-daemon = {
            format = "{icon}";
            tooltip-format = "Power profile: {profile}\nDriver: {driver}";
            tooltip = true;
            format-icons = {
              default = "";
              performance = "";
              balanced = "";
              power-saver = "";
            };
          };

          privacy = {
            ignore = [
              {
                type = "audio-in";
                name = "cava";
              }
            ];
          };

          tempurature = {
            thermal-zone = 1;
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = ["󰉬 " " " "󰉪 "];
          };

          wireplumber = {
            format = "{volume}% {icon} ";
            format-muted = "";
            on-click = "pwvucontrol";
            format-icons = ["" "" ""];
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

              position = literals.top;

              modules-left = [
                "cava"
                "niri/workspaces"
                "privacy"
              ];

              modules-center = [
                "niri/window"
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

              "group/group-hardware" = {
                orientation = "inherit";
                drawer = {
                  transition-duration = 500;
                  children-class = "not-cpu";
                };
                modules = [
                  "cpu"
                  "memory"
                  "network"
                  "temperature"
                ];
              };

              "group/group-power" = {
                orientation = "inherit";
                drawer = {
                  transition-duration = 500;
                  children-class = "not-power";
                };

                modules = [
                  "custom/power" # First element is the "group leader" and won't ever be hidden
                  "custom/quit"
                  "custom/reboot"
                ];
              };

              # custom modules

              "custom/quit" = {
                format = "󰗼";
                tooltip = false;
                on-click = "niri msg exit";
              };

              "custom/reboot" = {
                format = "󰜉";
                tooltip = false;
                on-click = "reboot";
              };

              "custom/power" = {
                format = "";
                tooltip = false;
                on-click = "shutdown now";
              };
            };
        };
      };
    };
  };
}
