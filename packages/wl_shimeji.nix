{
  stdenv,
  fetchFromGitHub,
  pkg-config,
  wayland,
  wayland-protocols,
  wayland-scanner,
  libarchive,
  uthash,
  python3,
  python313Packages,
  qoi,
}:
stdenv.mkDerivation {
  pname = " wl-shimeji";
  version = "faad975374a3ea7eaacc1526607ce210858d7a72";

  src = fetchFromGitHub {
    owner = "CluelessCatBurger";
    repo = "wl_shimeji";
    rev = "faad975374a3ea7eaacc1526607ce210858d7a72";
    hash = "sha256-MsaombtAS/3RhaNNWBnu7vlb0C7MIlCAn8Jil2YZEfs=";
  };
  buildInputs = [
    pkg-config
    wayland
    wayland-protocols
    wayland-scanner
    libarchive
    uthash
    python3
    python313Packages.pillow
    qoi
  ];
}
