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

    enableDefaultPackages = false;

    fontconfig.defaultFonts = let
      addAll = builtins.mapAttrs (_: v: ["Symbols Nerd Font"] ++ v ++ ["Noto Color Emoji"]);
    in
      addAll {
        serif = ["Noto Serif"];
        sansSerif = ["Inter"];
        monospace = ["JetBrains Mono"];
        emoji = [];
      };
  };
}
