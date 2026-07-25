{
  fetchFromGitHub,
  stdenv,
  ...
}:
stdenv.mkDerivation rec {
  installPhase = ''
    mkdir -p $out/bin
    cp sgx_enable $out/bin/sgx-software-enable
  '';
  pname = "sgx-software-enable";
  src = fetchFromGitHub {
    hash = "sha256-w5KD8NEF0vz2rIbnBhWeT5V/Wzp4Qn7A7n529AQhyGU=";
    owner = "intel";
    repo = "sgx-software-enable";
    rev = "v${version}";
  };
  version = "1.0";
}
