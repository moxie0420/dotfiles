{
  inputs,
  pkgs,
  self,
  ...
}: {
  # walpaper
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.system}.default;
    settings = {
      ipc = "on";
      splash = true;
      splash_offset = 2.0;

      preload = ["${self.packages.x86_64-linux.rosePineWallpapers}/bay.JPG"];

      wallpaper = [
        "DP-1,${self.packages.x86_64-linux.rosePineWallpapers}/bay.JPG"
        "HDMI-A-1,${self.packages.x86_64-linux.rosePineWallpapers}/bay.JPG"
      ];
    };
  };

  # application launcher
  programs.wofi.settings.stylesheet = "${self.packages.x86_64-linux.rosePineWofi}/rose-pine.rasi";

  # Hyprland
  wayland.windowManager.hyprland.settings.source = ["${self.packages.x86_64-linux.rosePineHyprland}/rose-pine.conf"];
  wayland.windowManager.hyprland.settings.general."col.active_border" = "$rose";
  wayland.windowManager.hyprland.settings.general."col.inactive_border" = "$muted";

  # XCursor
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "rose-pine";
    package = self.packages.x86_64-linux.rosePineCursor;
    size = 24;
  };
  home.sessionVariables.XCURSOR_THEME = "rose-pine";

  # Hyprcursor
  home.packages = [inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default self.packages.x86_64-linux.rosePineCursor];
  home.sessionVariables.HYPRCURSOR_THEME = "rose-pine-hyprcursor";

  # Vesktop
  xdg.configFile."vesktop/themes/rose-pine.theme.css".source = "${self.packages.x86_64-linux.rosePineVesktop}/rose-pine.theme.css";
  xdg.configFile."vesktop/themes/rose-pine-moon.theme.css".source = "${self.packages.x86_64-linux.rosePineVesktop}/rose-pine-moon.theme.css";

  # gtk
  gtk.theme.name = "rose-pine";
  gtk.theme.package = pkgs.rose-pine-gtk-theme;
  gtk.iconTheme.name = "rose-pine-icons";
  gtk.iconTheme.package = pkgs.rose-pine-icon-theme;
}
