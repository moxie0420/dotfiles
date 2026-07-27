{programs, ...}: {
  programs.git = {
    homeManager = {pkgs, ...}: {
      programs = {
        gh = {
          enable = true;
          gitCredentialHelper.enable = true;
        };

        git = {
          enable = true;
          lfs.enable = true;
          package = pkgs.gitFull;

          settings = {
            init.defaultBranch = "main";
          };
        };
      };
    };

    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) gh lazygit;
      };

      programs.git = {
        enable = true;

        lfs = {
          enable = true;
          enablePureSSHTransfer = true;
        };

        package = pkgs.gitFull;
      };
    };

    provides = {
      to-hosts.includes = [programs.git];
      to-users.includes = [programs.git];
    };
  };
}
