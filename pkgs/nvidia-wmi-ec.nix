{
  pkgs,
  lib,
  kernel ? pkgs.linuxPackages_latest.kernel,
}:
pkgs.stdenv.mkDerivation {
  pname = "nvidia-wmi-ec-backlight";
  inherit (kernel) src version postPatch nativeBuildInputs;

  kernel_dev = kernel.dev;
  kernelVersion = kernel.modDirVersion;

  modulePath = "drivers/platform/x86";

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
  meta = {
    description = "Nvidia wmi ec backlight with faulty firmware patch";
    license = lib.licenses.gpl3;
  };
}
