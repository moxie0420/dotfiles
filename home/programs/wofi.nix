{
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 420;
      location = "center";
      lines = 5;
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 32;
      gtk_dark = false;
    };
  };
}
