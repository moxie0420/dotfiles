{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/wallpapers
    cp **/*.jpg $out/share/wallpapers

    runHook postInstall
  '';

  pname = "rosePineWallpapers";

  src = fetchFromGitHub {
    hash = "";
    owner = "rose-pine";
    repo = "wallpapers";
    rev = "2bea14f4ee9e237e4fa43d7f18b56292b3f845a1";
  };

  version = "git";
}
