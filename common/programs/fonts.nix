{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      material-symbols

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
      roboto

      # monospace fonts
      jetbrains-mono

      # nerdfonts
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];
  };
}
