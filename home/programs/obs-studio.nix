{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      input-overlay
      obs-vkcapture
      obs-rgb-levels-filter
      obs-gradient-source
    ];
  };
}
