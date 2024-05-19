{pkgs, ...}: {
  services.xserver.desktopManager.retroarch = {
    enable = true;
    package = pkgs.retroarch;
  };
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = false;
      localNetworkGameTransfers.openFirewall = true;
      extest.enable = false;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode = {
      enable = true;
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
