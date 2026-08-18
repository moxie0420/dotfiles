{inputs, ...}: {
  flake-file.inputs.aagl.url = "github:ezKEa/aagl-gtk-on-nix";

  programs.anime-games-launcher = {
    nixos = {
      imports = [inputs.aagl.nixosModules.default];

      programs = {
        anime-game-launcher.enable = true;
        honkers-railway-launcher.enable = true;
      };
    };
  };
}
