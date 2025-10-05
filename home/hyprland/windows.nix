{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # tile Steam client only
      "float, class:^(steam)$"
      "tile, class:^(steam)$, title:^(Steam)$"

      # Fix some dragging issues with XWayland
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

      # Float in the middle for clipse clipboard manager
      "float, class:(clipse)"
      "size 622 652, class:(clipse)"
      "stayfocused, class:(clipse)"
    ];
  };
}
