{
  fetchzip,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  installPhase = ''
    mkdir -p $out
    mv * $out
  '';
  noBuild = true;
  pname = "CelesteNet";
  src = fetchzip {
    sha256 = "sha256-+WZ9hMc7IPVUcQLE+RjwsokF15K5SRdUJTDm6DfQP6Q=";
    url = "https://github.com/0x0ade/${pname}/releases/download/v${version}-server/CelesteNet.Server-2024-09-23_fixed.zip";
  };
  version = "2.4.1";
}
