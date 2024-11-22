{
  programs.cava = {
    enable = false;
    settings = {
      general.framerate = 60;
      input.method = "pipewire";
      smoothing.noise_reduction = 88;
      color = {
        foreground = "default";
      };
    };
  };
}
