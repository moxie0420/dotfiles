{programs, ...}: {
  programs.fzf = {
    homeManager.programs.fzf.enable = true;

    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) fzf;
      };

      programs = {
        fzf = {
          fuzzyCompletion = true;
          keybindings = true;
        };
      };
    };

    provides = {
      to-hosts.includes = [programs.fzf];
      to-users.includes = [programs.fzf];
    };
  };
}
