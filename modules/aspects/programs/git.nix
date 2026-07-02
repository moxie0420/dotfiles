{
  programs.git = {
    nixos = { pkgs, ... }: {
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

    homeManager = { pkgs, ... }: {
      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
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
  };
}
