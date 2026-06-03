### WARNING
#
# Ensure you have desktop.niri or or classes.niri
{desktop, ...}: {
  desktop.niri.windowRules = {
    defaults.includes = [
      desktop.niri.windowRules.gaming
    ];

    # Create a workspace for video games
    # should also ensure notifications work
    gaming = {
      # create the gaming workspace
      niri.workspaces.gaming = {};
      niri.window-rules = {
        steam = {
          matches = [
            {
              app-id = "steam";
            }
          ];
          open-on-workspace = "gaming";
        };

        steam-notifications = {
          matches = [
            {
              app-id = "steam";
              title = "r#\"^notificationtoasts_\\d+_desktop$\"#";
            }
          ];

          default-floating-position = {
            x = 10;
            y = 10;
            relative-to = "bottom-right";
          };
        };
      };
    };
  };
}
