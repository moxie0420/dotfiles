{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  installPhase = ''
    mkdir -p $out
    cp dist/* $out
  '';

  pname = "rosepine-qbittorrent";

  src = fetchFromGitHub {
    hash = "sha256-KZ0TTzajJ4erpDu3IYEJphYouoCVwQSxR+4Qs+PHNkk=";
    owner = "rose-pine";
    repo = "qbittorrent";
    rev = "a0414e45214c89d4a4dcd8ba09ff31e3361fa059";
  };

  version = "1.0.0";
}
