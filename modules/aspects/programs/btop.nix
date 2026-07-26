{
  lib,
  programs,
  ...
}: {
  programs.btop = {
    homeManager.programs.btop = {
      enable = true;

      # TODO config btop
      settings = lib.mkAfter {
        theme_background = false;
      };
    };

    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) btop;
      };
    };

    provides = {
      to-hosts.includes = [programs.btop];
      to-users.includes = [programs.btop];
    };
  };
}
