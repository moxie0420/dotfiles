{
  programs.wine.nixos = {pkgs, ...}: {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs) winetricks;
      inherit (pkgs.wineWow64Packages) waylandFull;
    };
  };
}
