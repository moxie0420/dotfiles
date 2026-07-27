{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "comicMono";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "dtinth";
    repo = "comic-mono-font";
    rev = "6a133be3235177801e2aaf80619afcd40071c9c0";
    hash = "sha256-FjW403y3hQmjlk2eGLQccjDeqbR+9mUnnTUWfWgVC/U=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp *.ttf $out/share/fonts/truetype
  '';
}
