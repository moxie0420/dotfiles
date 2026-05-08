{
  programs.tealdeer = {
    homeManager.programs.tealdeer = {
      enable = true;
      enableAutoUpdates = true;
    };
    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) tealdeer;
      };
    };
  };
}
