{den, ...}: {
  den = {
    aspects.pkgs.rosepine = {
      packages = {pkgs, ...}: {
        rose-pine-qbittorrent = pkgs.callPackage ../../pkgs/rose-pine/qbittorrent.nix {};
        rose-pine-rofi = pkgs.callPackage ../../pkgs/rose-pine/rofi.nix {};
        rose-pine-sddm = pkgs.callPackage ../../pkgs/rose-pine/sddm.nix {};
        rose-pine-wallpapers = pkgs.callPackage ../../pkgs/rose-pine/wallpapers.nix {};
      };
    };

    schema.flake-system.includes = [
      den.aspects.pkgs.rosepine
    ];
  };
}
