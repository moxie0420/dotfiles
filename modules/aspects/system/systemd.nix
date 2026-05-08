{
  system.systemd.nixos.systemd.settings.Manager = {
    DefaultTimeoutStartSec = "15s";
    DefaultTimeoutStopSec = "10s";
    RebootWatchdogSec = "45s";
    RuntimeWatchdogSec = "30s";
    DefaultLimitNOFILE = "2048:2097152";
  };
}
