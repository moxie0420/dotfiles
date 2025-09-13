{pkgs, ...}: {
  hardware = {
    cpu.x86.msr.enable = true;
    ksm.enable = true;
    opentabletdriver.enable = true;

    enableAllFirmware = true;
  };

  environment.systemPackages = with pkgs; [
    udiskie
    ntfs3g
    exfat
    libinput
    libinput-gestures
    lm_sensors
    lshw
    pciutils
    usbutils
  ];
}
