{
  desktop.waybar = {
    nixos.programs.waybar.enable = true;
    homeManager = {
      programs.waybar = {
        enable = true;
        settings = let
          literals = {
            top = "top";
          };

          barDefaults = {
            layer = "top";
            height = 30;
            width = 960;
          };

          clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
          };

          cpu = {
            format = "{usage}% ";
            tooltip = false;
          };

          idle_inhibitor = {
            format = "{icon}";
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
              balanced = "";
              power-saver = "";
            };
          };

          tempurature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = ["󰉬" "" "󰉪"];
          };
        in {
          mainBar =
            barDefaults
            // {
              inherit clock cpu idle_inhibitor memory network power-profiles-daemon tempurature;

              position = literals.top;

              modules-left = [
                "niri/workspaces"
              ];

              modules-center = [
                "niri/window"
              ];

              modules-right = [
                "idle_inhibitor"
                "wireplumber"
                "network"
                "power-profiles-daemon"
                "cpu"
                "memory"
                "temperature"
                "clock"
                "tray"
              ];
            };
        };
      };
    };
  };
}
