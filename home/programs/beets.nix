{
  programs.beets = {
    enable = true;
    mpdIntegration = {
      enableStats = true;
      enableUpdate = true;
    };
    settings = {
      directory = "/media/The_Store/Music";
      library = "~/musiclibrary.db";

      plugins = ["fetchart" "lyrics"];

      import = {
        copy = false;
        write = true;
      };
    };
  };
}
