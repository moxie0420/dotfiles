{
  stdenv,
  lib,
  pkgs,
}:
with pkgs;
  stdenv.mkDerivation rec {
    pname = "ue5";
    version = "5.3.2";

    src = requireFile {
      name = "Linux_Unreal_Engine_${version}.zip";
      url = "https://www.unrealengine.com/en-US/linux";
      sha256 = "0lr7s26n9wn6k9i7n28p8illkvxmq5js1dzy2096fiqf50mzqnda";
    };

    nativeBuildInputs = [
      unzip
    ];

    buildInputs = [
      glibc
    ];

    unpackPhase = ''
      unzip ${src}
    '';

    installPhase = ''
      ls $sourceRoot
    '';
  }
