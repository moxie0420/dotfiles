{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    overlayAttrs = {
      inherit
        (config.packages)
        comicMono
        rosePineCursor
        rosePineHyprland
        rosePineKitty
        rosePineSddm
        rosePineVesktop
        rosePineWallpapers
        rosePineWofi
        rosePineZen
        sgx-software-enable
        ;
    };
    packages = with pkgs; {
      comicMono = callPackage ./comicMono.nix {};
      rosePineCursor = callPackage ./rosePineCursor.nix {};
      rosePineHyprland = callPackage ./rosePineHyprland.nix {};
      rosePineKitty = callPackage ./rosePineKitty.nix {};
      rosePineSddm = callPackage ./rosePineSddm.nix {};
      rosePineVesktop = callPackage ./rosePineVesktop.nix {};
      rosePineWallpapers = callPackage ./rosePineWallpapers.nix {};
      rosePineWofi = callPackage ./rosePineWofi.nix {};
      rosePineZen = callPackage ./rosePineZen.nix {};
      sgx-software-enable = callPackage ./sgx-software-enable.nix {};
    };
  };
}
