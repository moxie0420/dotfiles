{...}: {
  imports = [
    ./boot.nix
    ./bt.nix
    ./disks.nix
    ./hardware.nix
    ./network.nix
    ../../common
    ./vr.nix
  ];
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
    NVD_BACKEND = "direct";
    NIXOS_OZONE_WL = 1;
  };

  hardware.keyboard.qmk.enable = true;

  system.stateVersion = "23.05";
}
