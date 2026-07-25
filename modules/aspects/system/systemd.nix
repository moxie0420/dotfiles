{
  system.systemd.nixos.systemd.settings.Manager = {
    DefaultLimitNOFILE = "2048:2097152";
    DefaultTimeoutStartSec = "15s";
    DefaultTimeoutStopSec = "10s";
    RebootWatchdogSec = "45s";
    RuntimeWatchdogSec = "30s";
  };
}
