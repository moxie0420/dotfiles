{
  den.aspects.git = let
    shared = {
      programs.git = {
        enable = true;
        lfs.enable = true;
      };
    };
  in {
    nixos = {pkgs, ...}:
      shared
      // {
        programs.git.package = pkgs.gitFull;
        environment.systemPackages = builtins.attrValues {
          inherit (pkgs) gh lazygit;
        };

        programs.git.lfs.enablePureSSHTransfer = true;
      };

    homeManager = {pkgs, ...}:
      shared
      // {
        programs.git = {
          package = pkgs.gitFull;

          settings.user = {
            name = "Madeline Benavides";
            email = "moxiebenavides@proton.me";
          };
        };
        programs.gh = {
          enable = true;
          gitCredentialHelper.enable = true;
        };
      };
  };
}
