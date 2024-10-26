{pkgs, ...}: {
  fonts = {
    fontconfig.defaultFonts = {
      serif = ["Comic Shanns Mono" "Liberation Serif"];
      sansSerif = ["Comic Shanns Mono" "Ubuntu" "Vazirmatn"];
      monospace = ["Comic Shanns Mono" "Ubuntu Mono"];
    };
    packages = with pkgs; [
      material-symbols

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-extra
      roboto

      # monospace fonts
      jetbrains-mono

      # nerdfonts
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly" "ComicShannsMono"];})
    ];
  };
}
