{programs, ...}: {
  programs.ripgrep = {
    homeManager.programs.ripgrep.enable = true;

    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) ripgrep;
      };
    };

    provides = {
      to-hosts.includes = [programs.ripgrep];
      to-users.includes = [programs.ripgrep];
    };
  };
}
