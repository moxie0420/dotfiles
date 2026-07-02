### WARNING
# Ensure you have desktop.niri or or classes.niri
{desktop, ...}: {
  desktop.niri.windowRules = {
    includes = [
      desktop.niri.windowRules.browsing
      desktop.niri.windowRules.gaming
    ];

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

    # Create a workspace for video games
    # should also ensure notifications work
    gaming = {
      homeManager.programs.niri.settings = {
        workspaces.Games = {};
        window-rules = [
          {
            matches = [
              {
                app-id = "steam";
              }
            ];
            open-on-workspace = "Games";
            open-maximized = true;
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
            matches = [
              {
                app-id = "steam";
                title = "r#\"^notificationtoasts_\\d+_desktop$\"#";
              }
            ];

            default-floating-position = {
              x = 0;
              y = 0;
              relative-to = "bottom-right";
            };
          }
        ];
      };
    };

    browsing.homeManager.programs.niri.settings = {
      workspaces.Browsing = {};
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
    };
  };
}
