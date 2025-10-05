{pkgs, ...}: {
  home.packages = [
    pkgs.chromaprint
    pkgs.ffmpeg
  ];
  programs.beets = {
    enable = false;

    package = pkgs.beets.override {
      pluginOverrides = {
        copyartifacts = {
          enable = true;
          propagatedBuildInputs = [pkgs.beetsPackages.copyartifacts];
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
        "copyartifacts"
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
      copyartifacts = {
        extensions = [".lrc" ".cue" ".log"];
      };
    };
  };
}
