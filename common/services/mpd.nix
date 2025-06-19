{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mpc
    rmpc
  ];

  services = {
    mpd = {
      enable = true;
      user = "moxie";
      musicDirectory = "/media/The_Store/Music";
      extraConfig = ''
        auto_update "yes"

        audio_output {
          type "pipewire"
          name "pipewire output"
          dsd "yes"
        }

        resampler {
          plugin "soxr"
          quality "very high"
        }
      '';
    };
    mpdscribble = {
      enable = true;

      journalInterval = 90;

      endpoints = {
        "last.fm" = {
          passwordFile = "/run/secrets/lastfm-password";
          username = "Eg42069";
        };
      };
    };
  };
}
