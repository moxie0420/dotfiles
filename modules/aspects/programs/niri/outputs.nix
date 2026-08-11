{
  desktop.niri.outputs = {
    homeManager = {
      wayland.windowManager.niri.settings = {
        output = [
          {
            _args = ["HDMI-A-1"];
            hot-corners.off = {};

            position._props = {
              x = 0;
              y = -1080;
            };
          }
          {
            _args = ["HDMI-A-2"];
            focus-at-startup = {};
            hot-corners.off = {};

            position._props = {
              x = 0;
              y = 0;
            };
          }
        ];
      };
    };
  };
}
