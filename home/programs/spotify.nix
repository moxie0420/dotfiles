{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  programs.spicetify = {
    enable = false;
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle # shuffle+ (special characters are sanitized out of ext names)
      hidePodcasts

      # Community extensions
      groupSession
      fullAlbumDate
      hidePodcasts
      volumePercentage
    ];
  };
}
