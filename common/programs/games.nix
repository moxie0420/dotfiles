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
    steam = {
      enable = true;

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
