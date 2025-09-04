{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mangohud
    lutris
  ];

  programs = {
    gamescope = {
      enable = false;
      capSysNice = false;
    };

    steam = {
      enable = true;
      package = pkgs.steam;

      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
        proton-cachyos
      ];
    };
  };
}
