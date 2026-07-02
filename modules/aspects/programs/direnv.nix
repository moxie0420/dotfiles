{
  programs.dev-tools = let
    inherit (builtins) attrValues;

    withDirEnv = {
      programs.direnv = {
        enable = true;
        silent = true;
        nix-direnv.enable = true;
      };
    };
  in {
    nixos = {pkgs, ...}:
      withDirEnv
      // {
        environment.systemPackages = attrValues {
          inherit (pkgs) devenv;
        };
      };

    homeManager = {pkgs, ...}:
      withDirEnv
      // {
        home.packages = attrValues {
          inherit (pkgs) devenv;
        };
      };
  };
}
