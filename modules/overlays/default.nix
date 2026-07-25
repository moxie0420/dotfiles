{withSystem, ...}: {
  flake.overlays.default = final: prev:
    withSystem prev.stdenv.hostPlatform.system (
      {config, ...}: {
        rosepine = {
          qbittorrent = config.packages.rose-pine-qbittorrent;
          rofi = config.packages.rose-pine-rofi;
          sddm = config.packages.rose-pine-sddm;
          wallpapers = config.packages.rose-pine-wallpapers;
        };

        sgx-software-enable = config.packages.sgx-software-enable;
      }
    );
}
