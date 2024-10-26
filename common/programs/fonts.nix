{
  pkgs,
  self,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      material-symbols

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-color-emoji
      noto-fonts-extra
      roboto

      # monospace fonts
      jetbrains-mono

      # nerdfonts
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
      (self.packages.x86_64-linux.comicMono)
    ];
  };
}
