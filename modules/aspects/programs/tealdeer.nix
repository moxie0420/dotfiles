{
  programs.tealdeer = {
    homeManager.programs.tealdeer = {
      enable = true;
    };
    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) tealdeer;
      };
    };
  };
}
