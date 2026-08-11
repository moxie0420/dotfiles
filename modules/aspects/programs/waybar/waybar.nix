{
  programs,
  # self,
  ...
}: {
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
              " "
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
            format = "{usage}%  ";
            tooltip = false;
          };
          idle_inhibitor = {
            format = "{icon} ";

            format-icons = {
              activated = " ";
              deactivated = " ";
            };
          };
          literals = {
            top = "top";
          };
          memory.format = "{}% ";
          network = {
            format-alt = "{ifname}: {ipaddr}/{cidr} ";
            format-disconnected = "Disconnected ⚠";
            format-ethernet = "{ipaddr}/{cidr} 󰊗 ";
            format-linked = "{ifname} (No IP) 󰊗 ";
            # interface = "wlp2*"; # (Optional) To force the use of this interface
            format-wifi = "{essid} ({signalStrength}%)  ";
            tooltip-format = "{ifname} via {gwaddr} 󰊗 ";
          };
          power-profiles-daemon = {
            format = "{icon}";

            format-icons = {
              balanced = " ";
              performance = " ";
              power-saver = " ";
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

              "custom/reboot" = {
                format = "󰜉";
                on-click = "reboot";
                tooltip = false;
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
                "cpu"
                "memory"
                "network"
                # "temperature"
                "systemd-failed-units"
                "tray"
                "clock"
                "custom/power"
                "custom/reboot"
              ];

              position = literals.top;
            };
        };

        style = ''


          #custom-power,
          #custom-reboot {
            padding: .35rem;
          }
        '';
      };

      # manual styling
      # xdg.configFile."waybar/style.css".source = "${self}/modules/aspects/programs/waybar/style.css";
    };

    nixos.programs.waybar.enable = true;

    provides = {
      to-hosts.includes = [programs.waybar];
      to-users.includes = [programs.waybar];
    };
  };
}
