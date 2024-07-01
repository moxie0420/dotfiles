{pkgs, ...}: {
  services.xserver.desktopManager.retroarch = {
    enable = true;
    package = pkgs.retroarch;
  };
  programs = {
    steam = {
      enable = true;
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
    steamcmd
    steam-tui
  ];
  hardware.steam-hardware.enable = true;
}
