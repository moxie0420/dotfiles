{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    input = lib.mkDefault {
      kb_layout = "us";
      kb_options = "compose:caps";

      follow_mouse = 1;

      sensitivity = 0;

      touchpad = {
        natural_scroll = false;
      };
    };
  };
}
