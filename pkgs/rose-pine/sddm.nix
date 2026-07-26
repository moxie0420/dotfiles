# sddm-rose-pine.nix
{
  fetchFromGitHub,
  libsForQt5,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/rose-pine
  '';

  pname = "sddm-rose-pine-theme";

  propagatedUserEnvPkgs = [
    libsForQt5.qt5.qtgraphicaleffects
  ];

  src = fetchFromGitHub {
    owner = "lwndhrst";
    repo = "sddm-rose-pine";
    rev = "v${version}";
    sha256 = "+WOdazvkzpOKcoayk36VLq/6lLOHDWkDykDsy8p87JE=";
  };

  version = "1.2";
}
