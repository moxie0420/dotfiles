{
  perSystem = {pkgs, ...}: {
    packages.rosePineZen = pkgs.stdenv.mkDerivation {
      name = "rosePineZen";
      src = pkgs.fetchFromGitHub {
        owner = "rose-pine";
        repo = "zen-browser";
        rev = "c797173371b84dfff8911c403cd04b07bbc34cb7";
        hash = "sha256-FGq1DO1q5nJ0NDmSCEiP9Paym/Dv0mjn3UllZOByqQA=";
      };

      installPhase = ''
        mkdir -p $out
        cp dist/* $out
      '';
    };
  };
}
