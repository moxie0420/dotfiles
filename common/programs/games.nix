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
      capSysNice = false;
    };

    ns-usbloader.enable = true;

    steam = {
      enable = true;

      gamescopeSession = {
        enable = true;
        args = ["-f" "-H 1080" "-W 1920"];
        env = {
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          __GL_GSYNC_ALLOWED = "1";
          GBM_BACKEND = "nvidia-drm";
          LIBVA_DRIVER_NAME = "nvidia";
          NVD_BACKEND = "direct";
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
        extraPkgs = pkgs:
          with pkgs; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
            gamescope
          ];
      };
    };
  };
}
