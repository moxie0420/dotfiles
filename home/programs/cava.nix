{
  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 30;
      input.method = "pipewire";
      smoothing.noise_reduction = 88;
      color = {
        foreground = "default";
      };
    };
  };
}
