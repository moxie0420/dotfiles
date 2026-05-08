{
  system.power = {
    nixos = {
      powerManagement = {
        enable = true;
        cpuFreqGovernor = "schedutil";
        powertop.enable = true;
      };

      services.power-profiles-daemon.enable = true;
      services.upower.enable = true;
    };
  };
}
