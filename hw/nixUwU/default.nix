{inputs, ...}: {
  imports = [
    ./boot.nix
    ./bt.nix
    ./disks.nix
    ./hardware.nix
    ./network.nix
    ../../common
  ];
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    #WLR_DRM_DEVICES = "/dev/dri/card1";
    __GL_GSYNC_ALLOWED = "1";
    NVD_BACKEND = "direct";
  };

  nix.settings = {
    # add binary caches
    trusted-public-keys = [
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
    substituters = [
      "https://nixpkgs-wayland.cachix.org"
    ];
  };

  nixpkgs = {
    config.permittedInsecurePackages = ["nix-2.15.3"];
  };

  programs.coolercontrol = {
    enable = true;
    nvidiaSupport = true;
  };

  system.stateVersion = "23.05";
}
