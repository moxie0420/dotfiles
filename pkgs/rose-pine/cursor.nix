{
  fetchzip,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation rec {
  installPhase = ''
    mkdir -p $out/share/icons/rose-pine
    cp -r * $out/share/icons/rose-pine
  '';
  pname = "rosePineCursor";
  src = fetchzip {
    hash = "sha256-t5xwAPGhuQUfGThedLsmtZEEp1Ljjo3Udhd5Ql3O67c=";
    url = "https://github.com/rose-pine/cursor/releases/download/v${version}/BreezeX-RosePine-Linux.tar.xz";
  };
  version = "1.1.0";
}
