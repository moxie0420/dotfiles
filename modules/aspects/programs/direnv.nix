{inputs, ...}: {
  flake-file.inputs.direnv-instant = {
    url = "github:Mic92/direnv-instant";
  };

  programs.direnv = {
    homeManager = {
      imports = [inputs.direnv-instant.homeModules.direnv-instant];

      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
          silent = true;
        };

        direnv-instant.enable = true;
      };
    };

    nixos = {
      imports = [inputs.direnv-instant.nixosModules.direnv-instant];

      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
          silent = true;
        };

        direnv-instant.enable = true;
      };
    };
  };
}
