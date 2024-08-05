{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  kmod,
}:
stdenv.mkDerivation rec {
  name = "ch341ser";
  version = "git";

  src = fetchFromGitHub {
    owner = "juliagoda";
    repo = "CH341SER";
    rev = "bc03825c014c064356c9e74fc94df56d239365ce";
    sha256 = "sha256-EO7gm08aA1TtbzlayfiBWU0Jqblqp6EguUzK11cPjJs=";
    leaveDotGit = true;
  };

  setSourceRoot = ''
    export sourceRoot=$(pwd)/source
  '';

  hardeningDisable = ["pic" "format"];
  nativeBuildInputs = [kmod] ++ kernel.moduleBuildDependencies;

  makeFlags =
    kernel.makeFlags
    ++ [
      "KERNELRELEASE=${kernel.modDirVersion}" # 3
      "KERNELDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" # 4
      "INSTALL_MOD_PATH=$(out)"
    ];
  patchPhase = ''
    sed -i '7s/$/\ modules/' Makefile
    echo $KERNELDIR
  '';
  buildPhase = ''
    make
  '';
  installPhase = ''
    cp ch34x.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/usb/serial
  '';

  meta = with lib; {
    description = "ch340 driver";
    homepage = "https://github.com/juliagoda/CH341SER";
  };
}
