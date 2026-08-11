{
  desktop.niri.layout = {
    homeManager = {
      wayland.windowManager.niri.settings = {
        layout = {
          center-focused-column = "never";
          gaps = 16;

          preset-column-widths._children = [
            {proportion = 0.33333;}
            {proportion = 0.5;}
            {proportion = 0.66667;}
            {proportion = 1.0;}
          ];

          shadow = {
            color = "#0007";

            offset._props = {
              x = 0;
              y = 5;
            };

            on = {};
            softness = 30;
            spread = 5;
          };
        };
      };
    };
  };
}
