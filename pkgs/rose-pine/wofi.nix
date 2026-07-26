{
  fetchFromGitHub,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';

  pname = "rosePineWofi";

  src = fetchFromGitHub {
    hash = "sha256-c97ivCgggRyaTiwzKVVKJLWRLgCRQxT58q+AhKNXETg=";
    owner = "cement-drinker";
    repo = "wofi-rose-pine";
    rev = "fe18b328511f5929dfa27dec6ffe8e2253b4bb5b";
  };

  version = "1.0.0";
}
