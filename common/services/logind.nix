{
  boot.kernelParams = ["mem_sleep_deefault=deep"];
  services.logind = {
    powerKey = "hybrid-sleep";
    popwerKeyLongPress = "poweroff";
    lidSwitch = "suspend-then-hibernate";
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=11m
    SuspendState=mem
  '';
}
