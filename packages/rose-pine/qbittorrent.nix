{
  fetchFromGithub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "qbittorrent";
  version = "1.0.0";

  src = fetchFromGithub {
    owner = "rose-pine";
    repo = "qbittorrent";
    rev = "a0414e45214c89d4a4dcd8ba09ff31e3361fa059";
    hash = "";
  };

  installPhase = ''
    mkdir -p $out
    cp dist/* $out
  '';
}
