{inputs, ...}: {
  flake-file.inputs.anime-games-launcher.url = "github:an-anime-team/anime-games-launcher";

  programs.anime-games-launcher = {
    nixos = {
      includes = [inputs.anime-games-launcher.nixosModules.anime-games-launcher];

      programs.anime-games-launcher = {
        anirun.enable = true;
        enable = true;
      };
    };
  };
}
