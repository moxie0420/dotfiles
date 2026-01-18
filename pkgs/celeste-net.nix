{
  fetchzip,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "CelesteNet";
  version = "2.4.1";

  src = fetchzip {
    url = "https://github.com/0x0ade/${pname}/releases/download/v${version}-server/CelesteNet.Server-2024-09-23_fixed.zip";
    sha256 = "sha256-+WZ9hMc7IPVUcQLE+RjwsokF15K5SRdUJTDm6DfQP6Q=";
  };

  noBuild = true;

  installPhase = ''
    mkdir -p $out
    mv * $out
  '';
}
