{
  home.sessionVariables = {
    # toolkit backends
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    # QT specific variables
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

    # Enable wayland for electron/chromium based software
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    NIXOS_OZONE_WL = 1;
    CHROMIUM_FLAGS = "--enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4";
  };
}
