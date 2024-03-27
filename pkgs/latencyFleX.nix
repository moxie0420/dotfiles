with import <nixpkgs> {};
stdenv.mkDerivation rec {
    pname = "latencyFlex";
    version = "0.1.1";

    dontConfigure = true;

    src = fetchFromGitHub {
        owner = "ishitatsuyuki";
        repo = "LatencyFlex";
        rev = "v${version}";
        fetchSubmodules = true;
        hash = "sha256-EwLcNu5+sSBBZbNVL9/EH+9rByGoWCSLKw5BNBLk618=";
    };
    buildInputs = [
        cmake
        meson
        ninja
        vulkan-headers
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
    ];

    buildPhase = ''
        cd layer
        meson setup build
        ninja -C build
    '';
}