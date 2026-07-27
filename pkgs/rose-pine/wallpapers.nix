{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "rose-pine-wallpapers";
  version = "2bea14f4ee9e237e4fa43d7f18b56292b3f845a1";

  src = fetchFromGitHub {
    owner = "rose-pine";
    repo = "wallpapers";
    rev = "2bea14f4ee9e237e4fa43d7f18b56292b3f845a1";
    hash = "sha256-miqBQPT8spHfdfSU+F69i6wj9yQE+9zJrgeE+tfNu4s=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/wallpapers/rose-pine

    cp --recursive generative $out/share/wallpapers/rose-pine
    cp --recursive illustration $out/share/wallpapers/rose-pine
    cp --recursive minecraft $out/share/wallpapers/rose-pine
    cp --recursive os $out/share/wallpapers/rose-pine
    cp --recursive photography $out/share/wallpapers/rose-pine

    runHook postInstall
  '';

  meta = {
    description = "Wallpapers with all natural pine, faux fur and a bit of soho vibes for the classy minimalist";
    homepage = "https://github.com/rose-pine/wallpapers";
    license = with lib.licenses; [cc0];
    platforms = lib.platforms.all;
  };
}
