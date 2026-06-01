{lib, ...}: let
  sharedAliases = {
    l = lib.mkDefault "ls";
    ls = lib.mkDefault "ls -l";
    ll = lib.mkDefault "ls -l";
    lla = lib.mkDefault "ll -a";
  };
in {
  system.shell.aliases = {
    nixos.environment.shellAliases = sharedAliases;
    homeManager.home.shellAliases = sharedAliases;
  };
}
