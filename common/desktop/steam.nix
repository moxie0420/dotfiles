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
    mangohud
    winetricks
    protonup-qt
  ];
  hardware.steam-hardware.enable = true;
}
