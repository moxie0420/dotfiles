{
  programs.ripgrep = {
    homeManager.programs.ripgrep.enable = true;
    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) ripgrep;
      };
    };
  };
}
