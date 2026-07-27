{
  system.power = {
    nixos = {
      powerManagement = {
        cpuFreqGovernor = "schedutil";
        enable = true;
        powertop.enable = true;
      };

      services = {
        power-profiles-daemon.enable = true;
        upower.enable = true;
      };
    };
  };
}
