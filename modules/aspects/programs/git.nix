{programs, ...}: {
  programs.git = {
    homeManager = {pkgs, ...}: {
      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };

      programs.git = {
        enable = true;
        package = pkgs.gitFull;
        lfs.enable = true;

        settings = {
          init.defaultBranch = "main";
        };
      };
    };
    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) gh lazygit;
      };

      programs.git = {
        enable = true;
        package = pkgs.gitFull;
        lfs = {
          enable = true;
          enablePureSSHTransfer = true;
        };
      };
    };
    provides = {
      to-hosts.includes = [programs.git];
      to-users.includes = [programs.git];
    };
  };
}
