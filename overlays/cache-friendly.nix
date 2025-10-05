{
  inputs,
  nixpkgs ? inputs.nixpkgs,
  lib' ? inputs.self.lib',
  nixpkgsConfig ? null,
}: userFinal: _userPrev: let
  inherit (userFinal) stdenv;
  inherit (stdenv.hostPlatform) system;

  isCross = stdenv.buildPlatform != stdenv.hostPlatform;

  config =
    if nixpkgsConfig == null
    then nixpkgs.legacyPackages.${system}.config
    else nixpkgsConfig;

  prev =
    if isCross
    then
      import nixpkgs {
        inherit config;
        localSystem = stdenv.buildPlatform;
        crossSystem = stdenv.hostPlatform;
      }
    else
      import nixpkgs {
        inherit config;
        localSystem = nixpkgs.legacyPackages."${system}".stdenv.hostPlatform;
      };
in
  lib'.applyOverlay {pkgs = prev;}
