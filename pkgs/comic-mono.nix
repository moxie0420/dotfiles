{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp *.ttf $out/share/fonts/truetype
  '';
  pname = "comicMono";
  src = fetchFromGitHub {
    hash = "sha256-FjW403y3hQmjlk2eGLQccjDeqbR+9mUnnTUWfWgVC/U=";
    owner = "dtinth";
    repo = "comic-mono-font";
    rev = "6a133be3235177801e2aaf80619afcd40071c9c0";
  };
  version = "0.1.1";
}
