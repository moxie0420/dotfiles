{
  fetchFromGitHub,
  stdenv,
  ...
}:
stdenv.mkDerivation rec {
  pname = "sgx-software-enable";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "intel";
    repo = "sgx-software-enable";
    rev = "v${version}";
    hash = "sha256-w5KD8NEF0vz2rIbnBhWeT5V/Wzp4Qn7A7n529AQhyGU=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp sgx_enable $out/bin/sgx-software-enable
  '';
}
