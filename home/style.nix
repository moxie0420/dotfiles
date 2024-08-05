{
  config,
  pkgs,
  ...
}: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";

    image = ../wallpapers/lain.jpg;

    cursor = {
      package = pkgs.catppuccin-cursors.mochaPink;
      name = "Catppuccin-Mocha-Pink-Cursors";
      size = 24;
    };

    fonts = {
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      monospace = {
        package = pkgs.nerdfonts;
        name = "ComicShannsMono";
      };
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
    };
    targets.waybar = {
      enable = true;
      enableCenterBackColors = false;
    };
    targets.vscode.enable = false;
  };
}
