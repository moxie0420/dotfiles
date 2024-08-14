{...}: {
  imports = [
    ./boot.nix
    ./bt.nix
    ./disks.nix
    ./hardware.nix
    ./network.nix
    ../../common
    ../../common/harden.nix
  ];
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    #WLR_NO_HARDWARE_CURSORS = "1";
    #WLR_DRM_DEVICES = "/dev/dri/card1";
    __GL_GSYNC_ALLOWED = "1";
    NVD_BACKEND = "direct";
    NIXOS_OZONE_WL = 1;
  };

  nix.settings = {
    # add binary caches
    trusted-public-keys = [
    ];
    substituters = [
    ];
  };

  hardware.keyboard.qmk.enable = true;

  nixpkgs = {
    config.permittedInsecurePackages = ["nix-2.15.3"];
  };

  programs.coolercontrol = {
    enable = true;
    nvidiaSupport = true;
  };

  system.stateVersion = "23.05";
}
