{
  environment.systemPackages = [
    # pkgs.wlx-overlay-s
  ];
  services.monado = {
    enable = false;
    defaultRuntime = true; # Register as default OpenXR runtime
  };
  #systemd.user.services.monado = {
  #  environment = {
  #    STEAMVR_LH_ENABLE = "1";
  #    XRT_COMPOSITOR_COMPUTE = "1";
  #  };
  #  serviceConfig.Nice = -20;
  #};
}
