{...}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    systemWide = true;
  };
  musnix = {
    enable = true;
    rtcqs.enable = true;
    das_watchdog.enable = true;
  };
}
