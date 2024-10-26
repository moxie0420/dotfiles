{
  perSystem = {pkgs, ...}: {
    packages.rosePineVencord = pkgs.stdenv.mkDerivation {
      name = "rosePineStarship";
      src = pkgs.fetchFromGitHub {
        owner = "rose-pine";
        repo = "starship";
        rev = "ed68857c08cf49dcbf2575c5d4f491155750d011";
        hash = "";
      };

      installPhase = ''
        mkdir -p $out
        cp rose-pine.toml $out
      '';
    };
  };
}
