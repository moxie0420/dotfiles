{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "rosePineVesktop";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "rose-pine";
    repo = "discord";
    rev = "2651b116511f5c476da7ec9eb413c4d84fa21064";
    hash = "sha256-bSS807BISqIMcpYobWn3rdQgZycZTXOXV+RHtNqakkU=";
  };

  installPhase = ''
    mkdir -p $out
    cp rose-pine-moon.theme.css $out
    cp rose-pine.theme.css $out
  '';
}
