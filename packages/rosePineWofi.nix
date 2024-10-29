{
  perSystem = {pkgs, ...}: {
    packages.rosePineWofi = pkgs.stdenv.mkDerivation {
      name = "rosePineWofi";
      src = pkgs.fetchFromGitHub {
        owner = "rose-pine";
        repo = "rofi";
        rev = "414bb2538713a874dbb357f19212c96a011e1ac8";
        hash = "sha256-PnXk3t0Ce8ButnSsZFe7Id9SqgsnVUUXGSlTAO1wcaY=";
      };

      installPhase = ''
        mkdir -p $out
        cp rose-pine* $out
      '';
    };
  };
}
