{
  pkgs,
  self,
  ...
}: {
  home.packages = [
    self.packages.${pkgs.system}.rmpc
  ];

  programs.cava.enable = true;

  services.mpdscribble = {
    enable = true;
    journalInterval = 90;

    endpoints = {
      "last.fm" = {
        passwordFile = "/run/secrets/lastfm-password";
        username = "Eg42069";
      };
    };
  };

  services.mpd = {
    enable = true;
    package = pkgs.mpd;
    musicDirectory = "~/Music";

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "pipewire output"
      }

      audio_output {
        type "fifo"
        name "cava_fifo"
        path "/tmp/cava_fifo"
        format "48000:24:2"
      }
    '';
  };
}
