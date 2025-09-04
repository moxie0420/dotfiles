{
  services.pipewire.extraConfig = {
    pipewire."92-bit-perfect" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [44100 48000 88200 96000 176400 192000];
      };
      "stream.properties" = {
        "resample.disable" = true;
      };
    };
  };
}
