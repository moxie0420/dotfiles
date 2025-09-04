{pkgs, ...}: {
  fonts = {
    fontconfig.defaultFonts = {
      serif = ["Maple Mono NF CN" "Symbols Nerd Font" "Noto Color Emoji"];
      sansSerif = ["Maple Mono NF CN" "Symbols Nerd Font" "Noto Color Emoji"];
      monospace = ["Maple Mono NF CN" "Symbols Nerd Font" "Noto Color Emoji"];
    };
    packages = with pkgs; [
      noto-fonts-color-emoji

      # monospace fonts
      maple-mono.NF-CN

      # nerdfonts
      nerd-fonts.symbols-only
    ];
  };
}
