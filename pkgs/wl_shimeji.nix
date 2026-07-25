{
  fetchFromGitHub,
  libarchive,
  pkg-config,
  python3,
  python313Packages,
  qoi,
  stdenv,
  uthash,
  wayland,
  wayland-protocols,
  wayland-scanner,
}:
stdenv.mkDerivation {
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
  pname = " wl-shimeji";
  src = fetchFromGitHub {
    hash = "sha256-MsaombtAS/3RhaNNWBnu7vlb0C7MIlCAn8Jil2YZEfs=";
    owner = "CluelessCatBurger";
    repo = "wl_shimeji";
    rev = "faad975374a3ea7eaacc1526607ce210858d7a72";
  };
  version = "faad975374a3ea7eaacc1526607ce210858d7a72";
}
