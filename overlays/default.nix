# deadnix: skip
final: prev: {
  comic-mono = final.callPackage ../pkgs/comic-mono.nix {};
  goignis = final.callPackage ../pkgs/goignis.nix {};
  rmpc-git = final.callPackage ../pkgs/rmpc.nix {};

  rose-pine-cursor = final.callPackage ../pkgs/rose-pine/cursor.nix {};
  rose-pine-hyprland = final.callPackage ../pkgs/rose-pine/hyprland.nix {};
  rose-pine-kitty = final.callPackage ../pkgs/rose-pine/kitty.nix {};
  rose-pine-qbittorrent = final.callPackage ../pkgs/rose-pine/qbittorrent.nix {};
  rose-pine-rofi = final.callPackage ../pkgs/rose-pine/rofi.nix {};
  rose-pine-sddm = final.callPackage ../pkgs/rose-pine/sddm.nix {};
  rose-pine-vesktop = final.callPackage ../pkgs/rose-pine/vesktop.nix {};
  rose-pine-wallpapers = final.callPackage ../pkgs/rose-pine/wallpapers.nix {};
  rose-pine-wofi = final.callPackage ../pkgs/rose-pine/wofi.nix {};
  rose-pine-zen = final.callPackage ../pkgs/rose-pine/zen.nix {};

  legcord = final.callPackage ../pkgs/legcord.nix {};
  nvidia-oc = final.callPackage ../pkgs/nvidia-oc.nix {};
  sgx-software-enable = final.callPackage ../pkgs/sgx-software-enable.nix {};
  wl-shimeji = final.callPackage ../pkgs/wl_shimeji.nix {};
}
