{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];
  perSystem = {pkgs, ...}: {
    packages = with pkgs; {
      comicMono = callPackage ./comicMono.nix {};

      rose-pine = {
        cursor = callPackage ./rose-pine/cursor.nix {};
        hyprland = callPackage ./rose-pine/hyprland.nix {};
        kitty = callPackage ./rose-pine/kitty.nix {};
        qbittorrent = callPackage ./rose-pine/qbittorrent.nix {};
        sddm = callPackage ./rose-pine/sddm.nix {};
        vesktop = callPackage ./rose-pine/vesktop.nix {};
        wallpapers = callPackage ./rose-pine/wallpapers.nix {};
        wofi = callPackage ./rose-pine/wofi.nix {};
        zen = callPackage ./rose-pine/zen.nix {};
      };

      sgx-software-enable = callPackage ./sgx-software-enable.nix {};
    };
  };
}
