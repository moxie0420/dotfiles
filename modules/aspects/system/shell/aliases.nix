{lib, ...}: let
  sharedAliases = {
    l = lib.mkDefault "ls";
    ll = lib.mkDefault "ls -l";
    lla = lib.mkDefault "ll -a";
    ls = lib.mkDefault "ls -l";
  };
in {
  system.shell.aliases = {
    homeManager.home.shellAliases = sharedAliases;
    nixos.environment.shellAliases = sharedAliases;
  };
}
