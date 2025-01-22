{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };

    ns-usbloader.enable = true;

    steam = {
      enable = true;

      gamescopeSession = {
        enable = true;
        args = ["--adaptive-sync" "-H 2160" "-W 3840" "--expose-wayland" "--adaptive-sync" "--force-grab-cursor"];
        env = {
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          __GL_GSYNC_ALLOWED = "1";
          GBM_BACKEND = "nvidia-drm";
          LIBVA_DRIVER_NAME = "nvidia";
          NVD_BACKEND = "direct";

          PROTON_ENABLE_NVAPI = "1";
          PROTON_ENABLE_NGX_UPDATER = "1";
        };
      };

      localNetworkGameTransfers.openFirewall = true;
      platformOptimizations.enable = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

      package = pkgs.steam.override {
        extraEnv = {
          PROTON_HIDE_NVIDIA_GPU = false;
          PROTON_ENABLE_NVAPI = true;
        };
      };
    };
  };
}
