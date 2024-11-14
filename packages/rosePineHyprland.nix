{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "rosePineHyprland";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "rose-pine";
    repo = "hyprland";
    rev = "6898fe967c59f9bec614a9a58993e0cb8090d052";
    hash = "sha256-obIYZ0ctDrqf8g9DMAQlkfklelpfVYTrnhG9W33OPdE=";
  };

  installPhase = ''
    mkdir -p $out
    cp *.conf $out
  '';
}
