{
  system.fonts = {
    nixos = {
      lib,
      pkgs,
      ...
    }: {
      fonts.fontconfig = {
        enable = true;
        defaultFonts =
          lib.genAttrs ["serif" "sansSerif" "monospace"] (name: [
            "Maple Mono NF CN"
            "Noto Color Emoji"
          ])
          // {
            emoji = ["Noto Color Emoji"];
          };
      };

      fonts.packages = builtins.attrValues {
        inherit
          (pkgs)
          material-symbols
          noto-fonts
          noto-fonts-color-emoji
          noto-fonts-cjk-sans
          ;
      };
    };
  };
}
