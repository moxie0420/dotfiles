{
  inputs,
  pkgs,
  self,
  ...
}: {
  # wallpaper

  # application launcher
  programs.wofi.settings.stylesheet = "${self.packages.x86_64-linux.rosePineWofi}/rosepine/style.css";

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
    size = 16;
  };
  home.sessionVariables.XCURSOR_THEME = "rose-pine";
  home.sessionVariables.XCURSOR_SIZE = "16";

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

  # spotify
  programs.spicetify.theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.ziro;
  programs.spicetify.colorScheme = "rose-pine";

  # zen
  home.file.".zen/8combnke.Default Profile/chrome/userChrome.css".source = "${self.packages.x86_64-linux.rosePineZen}/userChrome.css";
  home.file.".zen/8combnke.Default Profile/chrome/rose-pine-main.css".source = "${self.packages.x86_64-linux.rosePineZen}/rose-pine-main.css";
}
