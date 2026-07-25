{
  inputs,
  programs,
  ...
}: {
  flake-file.inputs.nix-gaming-edge = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:powerofthe69/nix-gaming-edge";
  };

  programs.steam = {
    includes = [
      programs.steam.substituters
    ];
    nixos = {pkgs, ...}: {
      programs.steam = {
        enable = true;
        extraCompatPackages = builtins.attrValues {
          inherit (pkgs) proton-cachyos-x86_64-v3;
        };
        localNetworkGameTransfers.openFirewall = true;
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
