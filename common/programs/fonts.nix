{
  pkgs,
  self,
  ...
}: let
  inherit (self.packages.x86_64-linux) comic-mono;
in {
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
      comic-mono

      # nerdfonts
      nerd-fonts.symbols-only
    ];
  };
}
