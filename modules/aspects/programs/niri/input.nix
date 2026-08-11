{
  desktop.niri.input = {
    homeManager = {
      wayland.windowManager.niri.settings = {
        input = {
          focus-follows-mouse._props.max-scroll-amount = "0%";
          mouse.accel-profile = "flat";

          touchpad = {
            accel-profile = "adaptive";
            accel-speed = 0.2;
            disabled-on-external-mouse = {};
            natural-scroll = {};
            scroll-method = "two-finger";
            tap = {};
          };

          warp-mouse-to-focus._props.mode = "center-xy";
        };
      };
    };
  };
}
