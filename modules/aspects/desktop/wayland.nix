{
  desktop.wayland = {
    nixos = {
      services.displayManager.gdm = {
        enable = true;
        wayland = true;
        autoSuspend = false;
      };

      xdg.portal.enable = true;

      environment.sessionVariables = {
        # Prefer using Ozone because we're under Wayland.
        # Otherwise some Electron apps would start under X-Wayland.
        NIXOS_OZONE_WL = "1";

        # Set Wayland as the preferred display backend
        # fallback to x11 in some supported toolkits
        # GDK_BACKEND = "wayland,x11,*";
        QT_QPA_PLATFORM = "wayland;xcb";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";

        # disable scaling and window decorations for qt apps
        QT_AUTO_SCREEN_SCALE_FACTOR = 1;
        QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      };
    };
    homeManager = {pkgs, ...}: {
      home.packages = builtins.attrValues {
        inherit (pkgs) wl-clipboard;
      };

      # Enable Cliphist
      services.cliphist.enable = true;
      services.cliphist.extraOptions = [
        "-max-dedupe-search"
        "10"
        "-max-items"
        "500"
      ];
    };
  };
}
