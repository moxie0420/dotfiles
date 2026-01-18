{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 4;
      gaps_out = 8;

      border_size = 2;

      resize_on_border = false;
      allow_tearing = false;

      layout = "dwindle";
    };

    decoration = {
      rounding = 10;
      rounding_power = 2.0;
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      shadow = {
        enabled = false;
        range = 4;
        render_power = 3;
      };

      blur = {
        enabled = true;
        size = 5;
        passes = 2;

        vibrancy = 0.1696;
      };
    };

    animations = {
      enabled = true; # yes, please :)

      bezier = [
        "expressiveFastSpatial, 0.42, 1.67, 0.21, 0.90"
        "expressiveSlowSpatial, 0.39, 1.29, 0.35, 0.98"
        "expressiveDefaultSpatial, 0.38, 1.21, 0.22, 1.00"

        "emphasizedDecel, 0.05, 0.7, 0.1, 1"
        "standardDecel, 0, 0, 0, 1"
        "menuDecel, 0.1, 1, 0, 1"

        "emphasizedAccel, 0.3, 0, 0.8, 0.15"
        "menuAccel, 0.52, 0.03, 0.72, 0.08"
      ];

      animation = [
        # windows
        "windowsIn, 1, 3, emphasizedDecel, popin 80%"
        "windowsOut, 1, 2, emphasizedAccel, popin 90%"
        "windowsMove, 1, 3, expressiveDefaultSpatial, slide"
        "border, 1, 10, emphasizedDecel"
        # layers
        "layersIn, 1, 3, emphasizedDecel, popin 93%"
        "layersOut, 1, 2, emphasizedAccel, popin 94%"
        # fade
        "fadeOut, 0"
        "fadeLayersIn, 1, 0.5, menuDecel"
        "fadeLayersOut, 1, 2, menuAccel"
        # workspaces
        "workspaces, 1, 3, emphasizedDecel, fade"
        "specialWorkspaceIn, 1, 2.8, emphasizedDecel, slidevert"
        "specialWorkspaceOut, 1, 1.2, emphasizedAccel, slidevert"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_status = "master";
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
    };
  };
}
