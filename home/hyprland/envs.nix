{
  home.sessionVariables = {
    XCURSOR_SIZE = 24;
    HYPRCURSOR_SIZE = 24;

    XCURSOR_THEME = "rose-pine";
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";

    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_STYLE_OVERRIDE = "kvantum";
    SDL_VIDEODRIVER = "wayland";
    MOZ_ENABLE_WAYLAND = 1;
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    NIXOS_OZONE_WL = 1;

    CHROMIUM_FLAGS = "--enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4";

    XDG_DATA_DIRS = "$XDG_DATA_DIRS:$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share";

    XCOMPOSEFILE = "~/.XCompose";
    EDITOR = "hx";
  };
}
