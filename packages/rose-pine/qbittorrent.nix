{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "qbittorrent";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "rose-pine";
    repo = "qbittorrent";
    rev = "a0414e45214c89d4a4dcd8ba09ff31e3361fa059";
    hash = "sha256-KZ0TTzajJ4erpDu3IYEJphYouoCVwQSxR+4Qs+PHNkk=";
  };

  installPhase = ''
    mkdir -p $out
    cp dist/* $out
  '';
}
