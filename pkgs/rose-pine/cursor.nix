{
  fetchzip,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "rosePineCursor";
  version = "1.1.0";

  src = fetchzip {
    url = "https://github.com/rose-pine/cursor/releases/download/v${version}/BreezeX-RosePine-Linux.tar.xz";
    hash = "sha256-t5xwAPGhuQUfGThedLsmtZEEp1Ljjo3Udhd5Ql3O67c=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/rose-pine
    cp -r * $out/share/icons/rose-pine
  '';
}
