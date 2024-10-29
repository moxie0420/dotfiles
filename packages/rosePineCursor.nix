{
  perSystem = {pkgs, ...}: {
    packages.rosePineCursor = let
      version = "v1.1.0";
    in
      pkgs.stdenv.mkDerivation {
        name = "rosePineCursor";
        inherit version;
        src = pkgs.fetchzip {
          url = "https://github.com/rose-pine/cursor/releases/download/${version}/BreezeX-RosePine-Linux.tar.xz";
          hash = "sha256-t5xwAPGhuQUfGThedLsmtZEEp1Ljjo3Udhd5Ql3O67c=";
        };

        installPhase = ''

          mkdir -p $out/share/icons/rose-pine
          cp -r * $out/share/icons/rose-pine
          ln -s $out/$out/share/icons/rose-pine
        '';
      };
  };
}
