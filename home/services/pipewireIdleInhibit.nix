{inputs, ...}: {
  imports = [inputs.wayland-pipewire-idle-inhibit.homeModules.default];

  services.wayland-pipewire-idle-inhibit = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    settings = {
      verbosity = "WARN";
      media_minimum_duration = 5;
      idle_inhibitor = "wayland";
      sink_whitelist = [
        {name = "QUAD-CAPTURE Analog Surround 4.0";}
      ];
    };
  };
}
