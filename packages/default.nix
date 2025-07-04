{
  perSystem = {pkgs, ...}: {
    packages = {
      comic-mono = pkgs.callPackage ./comic-mono.nix {};
      rmpc = pkgs.callPackage ./rmpc.nix {};
      rose-pine-cursor = pkgs.callPackage ./rose-pine/cursor.nix {};
      rose-pine-hyprland = pkgs.callPackage ./rose-pine/hyprland.nix {};
      rose-pine-kitty = pkgs.callPackage ./rose-pine/kitty.nix {};
      rose-pine-qbittorrent = pkgs.callPackage ./rose-pine/qbittorrent.nix {};
      rose-pine-rofi = pkgs.callPackage ./rose-pine/rofi.nix {};
      rose-pine-sddm = pkgs.callPackage ./rose-pine/sddm.nix {};
      rose-pine-vesktop = pkgs.callPackage ./rose-pine/vesktop.nix {};
      rose-pine-wallpapers = pkgs.callPackage ./rose-pine/wallpapers.nix {};
      rose-pine-wofi = pkgs.callPackage ./rose-pine/wofi.nix {};
      rose-pine-zen = pkgs.callPackage ./rose-pine/zen.nix {};
      legcord = pkgs.callPackage ./legcord.nix {};
      nvidia-oc = pkgs.callPackage ./nvidia-oc.nix {};
      sgx-software-enable = pkgs.callPackage ./sgx-software-enable.nix {};
    };
  };
}
