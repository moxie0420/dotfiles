{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  installPhase = ''
    mkdir -p $out
    cp *.conf $out
  '';

  pname = "rosePineHyprland";

  src = fetchFromGitHub {
    hash = "sha256-obIYZ0ctDrqf8g9DMAQlkfklelpfVYTrnhG9W33OPdE=";
    owner = "rose-pine";
    repo = "hyprland";
    rev = "6898fe967c59f9bec614a9a58993e0cb8090d052";
  };

  version = "1.0.0";
}
