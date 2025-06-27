{pkgs, ...}: {
  services.pipewire.extraConfig = {
    pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 192000;
        "default.clock.allowed-rates" = [44100 48000 88200 96000 176400 192000];
        "default.clock.quantum" = 256;
        "default.clock.min-quantum" = 256;
        "default.clock.max-quantum" = 256;
      };
      "stream.properties" = {
        "resample.disable" = true;
      };
    };

    pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args.pulse = {
            min.req = "256/192000";
            default.req = "256/192000";
            max.req = "256/192000";
            min.quantum = "256/192000";
            max.quantum = "256/192000";
          };
        }
      ];
    };
  };

  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/main.lua.d/99-alsa-lowlatency.lua" ''
        alsa_monitor.rules = {
        {
          matches = {{{ "node.name", "matches", "alsa_output.usb-ZOOM_Corporation_UAC-2*" }}};
          apply_properties = {
            ["audio.format"] = "S32LE",
            ["audio.rate"] = "384000", -- for USB soundcards it should be twice your desired rate
            ["audio.allowed-rates] = "88200,96000,176000,192000,352800,384000"
            ["api.alsa.period-size"] = 256, -- defaults to 1024, tweak by trial-and-error
            -- ["api.alsa.disable-batch"] = true, -- generally, USB soundcards use the batch mode
          },
        },
      }
    '')
  ];
}
