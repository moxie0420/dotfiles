{ stdenv, lib }:

with pkgs;

stdenv.mkDerivation rec {
    pname = "ue5";
    version = "5.3.2";

    src = requireFile {
        name = "Linux_Unreal_Engine_${version}.zip";
        url = "https://www.unrealengine.com/en-US/linux";
        sha256 = "";
    };

    buildInputs = [
        glibc
    ];

    installPhase = ''
        ls $sourceRoot
    '';
}