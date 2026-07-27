{
  pkgs,
  kernel ? pkgs.linuxPackages_latest.kernel,
}:
pkgs.stdenv.mkDerivation {
  inherit
    (kernel)
    src
    version
    postPatch
    nativeBuildInputs
    ;

  pname = "alsa-quadcapture";

  patches = [
    ./alsa-quadcapture.patch
  ];

  buildPhase = ''
    BUILT_KERNEL=$kernel_dev/lib/modules/$kernelVersion/build

    cp $BUILT_KERNEL/Module.symvers .
    cp $BUILT_KERNEL/.config        .
    cp $kernel_dev/vmlinux          .

    make "-j$NIX_BUILD_CORES" modules_prepare
    make "-j$NIX_BUILD_CORES" M=$modulePath modules
  '';

  installPhase = ''
    make \
      INSTALL_MOD_PATH="$out" \
      XZ="xz -T$NIX_BUILD_CORES" \
      M="$modulePath" \
      modules_install
  '';

  kernelVersion = kernel.modDirVersion;
  kernel_dev = kernel.dev;
  modulePath = "sound/usb";
}
