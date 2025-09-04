{pkgs, ...}: {
  imports = [
    ./mobiledevices.nix
  ];

  hardware.opentabletdriver.enable = true;

  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0094", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0094", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEM=="input", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0094", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  environment.systemPackages = with pkgs; [
    udiskie
    ntfs3g
    exfat
    libinput
    libinput-gestures
    lm_sensors
    pciutils
    usbutils
  ];
}
