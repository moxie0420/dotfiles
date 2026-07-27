{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "rosePineKitty";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "rose-pine";
    repo = "kitty";
    rev = "788bf1bf1a688dff9bbacbd9e516d83ac7dbd216";
    hash = "sha256-AcMVkliLGuabZVGkfQPLhfspkaTZxPG5GyuJdzA4uSg=";
  };

  installPhase = ''
    mkdir -p $out
    cp -r dist $out/themes
    cp -r icons $out/icons
  '';
}
