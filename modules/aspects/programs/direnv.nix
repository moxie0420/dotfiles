{
  programs.direnv = {
    homeManager = {pkgs, ...}: {
      home.packages = builtins.attrValues {
        inherit (pkgs) devenv;
      };
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
      };
    };
    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) devenv;
      };
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
      };
    };
  };
}
