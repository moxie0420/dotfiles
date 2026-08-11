{
  flake-file.inputs.nix-gaming-edge = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:powerofthe69/nix-gaming-edge";
  };

  programs.steam = {
    nixos = {pkgs, ...}: {
      programs.steam = {
        enable = true;

        extraCompatPackages = builtins.attrValues {
          inherit (pkgs) proton-cachyos-x86_64-v3;
        };

        localNetworkGameTransfers.openFirewall = true;

        package = pkgs.steam.override {
          extraPkgs = pkgs':
            with pkgs'; [
              libXcursor
              libXi
              libXinerama
              libXScrnSaver
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib # Provides libstdc++.so.6
              libkrb5
              keyutils
              # Add other libraries as needed
            ];
        };

        protontricks.enable = true;
        remotePlay.openFirewall = true;
      };
    };

    substituters.nix = {
      substituters = ["https://nix-cache.tokidoki.dev/tokidoki"];
      trusted-public-keys = ["tokidoki:MD4VWt3kK8Fmz3jkiGoNRJIW31/QAm7l1Dcgz2Xa4hk="];
    };
  };
}
