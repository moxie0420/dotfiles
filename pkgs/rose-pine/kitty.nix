{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  installPhase = ''
    mkdir -p $out
    cp -r dist $out/themes
    cp -r icons $out/icons
  '';
  pname = "rosePineKitty";
  src = fetchFromGitHub {
    hash = "sha256-AcMVkliLGuabZVGkfQPLhfspkaTZxPG5GyuJdzA4uSg=";
    owner = "rose-pine";
    repo = "kitty";
    rev = "788bf1bf1a688dff9bbacbd9e516d83ac7dbd216";
  };
  version = "1.0.0";
}
