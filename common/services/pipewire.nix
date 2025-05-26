{pkgs, ...}: {
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    systemWide = true;
    package = pkgs.pipewire;

    extraConfig = {
      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 64;
          "default.clock.min-quantum" = 64;
          "default.clock.max-quantum" = 64;
        };
      };

      pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args.pulse = {
              min.req = "64/48000";
              default.req = "64/48000";
              max.req = "64/48000";
              min.quantum = "64/48000";
              max.quantum = "64/48000";
            };
          }
        ];
        stream.properties = {
          node.latency = "64/48000";
          resample.quality = 1;
        };
      };
    };
  };
}
