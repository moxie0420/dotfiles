{
  perSystem = {pkgs, ...}: {
    packages.rosePineWofi = pkgs.stdenv.mkDerivation {
      name = "rosePineWofi";
      src = pkgs.fetchFromGitHub {
        owner = "cement-drinker";
        repo = "wofi-rose-pine";
        rev = "fe18b328511f5929dfa27dec6ffe8e2253b4bb5b";
        hash = "sha256-c97ivCgggRyaTiwzKVVKJLWRLgCRQxT58q+AhKNXETg=";
      };

      installPhase = ''
        mkdir -p $out
        cp -r * $out
      '';
    };
  };
}
