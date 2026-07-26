{programs, ...}: {
  programs.tealdeer = {
    homeManager.programs.tealdeer = {
      enable = true;
    };

    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) tealdeer;
      };
    };

    provides = {
      to-hosts.includes = [programs.tealdeer];
      to-users.includes = [programs.tealdeer];
    };
  };
}
