### WARNING
# Ensure you have desktop.niri or or classes.niri
{desktop, ...}: {
  desktop.niri.windowRules = {
    browsing.homeManager.programs.niri.settings = {
      window-rules = [
        {
          matches = [
            {
              app-id = "firefox";
            }
          ];

          open-on-workspace = "Browsing";
        }
      ];

      workspaces.Browsing = {};
    };

    # Create a workspace for video games
    # should also ensure notifications work
    gaming = {
      homeManager.programs.niri.settings = {
        window-rules = [
          {
            matches = [
              {
                app-id = "steam";
              }
            ];

            open-maximized = true;
            open-on-workspace = "Games";
          }

          {
            matches = [
              {
                app-id = "steam";
                title = "Steam Settings";
              }
            ];

            open-floating = true;
          }

          {
            default-floating-position = {
              relative-to = "bottom-right";
              x = 0;
              y = 0;
            };

            matches = [
              {
                app-id = "steam";
                title = "r#\"^notificationtoasts_\\d+_desktop$\"#";
              }
            ];
          }
        ];

        workspaces.Games = {};
      };
    };

    homeManager.programs.niri.settings.window-rules = [
      {
        # background-effect.blur = true;

        clip-to-geometry = true;

        geometry-corner-radius = {
          bottom-left = 8.0;
          bottom-right = 8.0;
          top-left = 8.0;
          top-right = 8.0;
        };
      }
    ];

    includes = [
      desktop.niri.windowRules.browsing
      desktop.niri.windowRules.gaming
    ];
  };
}
