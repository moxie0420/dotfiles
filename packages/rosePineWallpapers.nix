{
  perSystem = {pkgs, ...}: {
    packages.rosePineWallpapers = pkgs.stdenv.mkDerivation {
      name = "rosePineWallpapers";
      src = pkgs.fetchFromGitHub {
        owner = "rose-pine";
        repo = "wallpapers";
        rev = "ccc865d5e83f9d6b51e289ff1016fcd60749b11a";
        hash = "sha256-7jaFqVXs6T3S818IBD3CLjNgDYuc5/ibMWCCnlbtUHw=";
      };

      installPhase = ''
        mkdir -p $out
        cp *.png $out
        cp *.jpg $out
        cp *.JPG $out
      '';
    };
  };
}
