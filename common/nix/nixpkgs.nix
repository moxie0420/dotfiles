{
  inputs,
  config,
  pkgs,
  ...
}: {
  _module.args.pkgsStable = import inputs.nixpkgs-stable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
