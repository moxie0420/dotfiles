{
  fetchFromGitHub,
  stdenv,
  ...
}:
stdenv.mkDerivation {
  installPhase = ''
    mkdir -p $out
    cp dist/* $out
  '';
  pname = "rosePineZen";
  src = fetchFromGitHub {
    hash = "sha256-FGq1DO1q5nJ0NDmSCEiP9Paym/Dv0mjn3UllZOByqQA=";
    owner = "rose-pine";
    repo = "zen-browser";
    rev = "c797173371b84dfff8911c403cd04b07bbc34cb7";
  };
  version = "1.0.0";
}
