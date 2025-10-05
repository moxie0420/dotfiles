{
  fetchFromGitHub,
  stdenvNoCC,
  pkgs,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "rosePineWallpapers";
  version = "git";
  src = fetchFromGitHub {
    owner = "rose-pine";
    repo = "wallpapers";
    rev = "ccc865d5e83f9d6b51e289ff1016fcd60749b11a";
    hash = "sha256-7jaFqVXs6T3S818IBD3CLjNgDYuc5/ibMWCCnlbtUHw=";
  };

  nativeBuildInputs = with pkgs; [imagemagick];

  buildPhase = ''
    runHook preBuild

    mogrify -format png *.[Jj][Pp][Gg]

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/wallpapers
    cp *.png $out/share/wallpapers

    runHook postInstall
  '';
}
