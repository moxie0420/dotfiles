{pkgs, ...}: {
  home.packages = [
    pkgs.chromaprint
    pkgs.ffmpeg
  ];
  programs.beets = {
    enable = true;

    package = pkgs.beets.override {
      pluginOverrides = {
        filetote = {
          enable = true;
          propagatedBuildInputs = [pkgs.beetsPackages.filetote];
        };
      };
    };

    mpdIntegration = {
      enableStats = true;
      enableUpdate = true;
    };

    settings = {
      directory = "~/Music";
      library = "~/musicLibrary.db";

      plugins = [
        "fetchart"
        "thumbnails"
        "lyrics"
        "ftintitle"
        "duplicates"
        "chroma"
        "filetote"
        "badfiles"
        "missing"
        "replaygain"
        "unimported"
      ];

      import = {
        copy = false;
        write = true;
      };

      lyrics = {
        synced = true;
        sources = [
          "lrclib"
          "genius"
        ];
      };

      ftintitle = {
        format = "ft. {0}";
      };

      chroma = {
        auto = true;
      };
      replaygain = {
        backend = "ffmpeg";
      };
      filetote = {
        extensions = [".lrc" ".cue" ".log"];
      };
    };
  };
}
