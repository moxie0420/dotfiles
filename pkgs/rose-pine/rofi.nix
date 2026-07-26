{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  installPhase = ''
    mkdir -p $out
    cp *.rasi * $out
  '';

  pname = "rosePineRofi";

  src = fetchFromGitHub {
    hash = "sha256-V1o8Rv9Jcojp25qOoDm/QWOb7woMVrSXH/xZHAiitB0=";
    owner = "rose-pine";
    repo = "rofi";
    rev = "3dbfdeae8d80159b1e5cae98c6752cef84057d11";
  };

  version = "1.0.0";
}
