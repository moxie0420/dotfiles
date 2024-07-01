{
  config,
  pkgs,
  ...
}: {
  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        obs-webkitgtk
        obs-input-overlay
      ];
    };
  };
}
