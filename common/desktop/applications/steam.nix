{pkgs, ...}: {
  services.xserver.desktopManager.retroarch = {
    enable = true;
    package = pkgs.retroarch;
  };
  programs = {
    steam = {
      enable = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession = {
        enable = false;
        args = ["-e -f"];
        env = {
          SCREEN_HEIGHT = "2160";
          SCREEN_WIDTH = "3840";

          CLIENTCMD = "steam -steamos -pipewire-dmabuf";
        };
      };
      localNetworkGameTransfers.openFirewall = true;
      extest.enable = false;
      package = pkgs.steam.override {
        extraEnv = {
          OBS_VKCAPTURE = true;
          PROTON_HIDE_NVIDIA_GPU = false;
          PROTON_ENABLE_NVAPI = true;
        };
      };
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode = {
      enable = false;
      enableRenice = true;
    };
  };
  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    winetricks
    protontricks
    protonup-qt
  ];
  hardware.steam-hardware.enable = true;
}
