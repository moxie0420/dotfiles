{
  pkgs,
  self,
  ...
}: {
  fonts = {
    fontconfig.defaultFonts = {
      serif = ["Comic Mono" "Symbols Nerd Font"];
      sansSerif = ["Comic Mono" "Symbols Nerd Font"];
      monospace = ["Comic Mono" "Symbols Nerd Font"];
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-extra
      roboto

      # monospace fonts
      self.packages.x86_64-linux.comicMono

      # nerdfonts
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];
  };
}
