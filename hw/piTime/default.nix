{ pkgs, ... }:
{
  imports = [
    ./sound.nix
  ];

  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;

      raspberryPi.firmwareConfig = ''
        dtparam=audio=on
      '';
    };
    kernelPackages = pkgs.linuxPackages_rpi3;
    kernelParams = [
      "console=ttyS1,115200n8"
    ];
  };

  systemd.services.btattach = {
    before = [ "bluetooth.service" ];
    after = [ "dev-ttyAMA0.device" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bluez}/bin/btattach -B /dev/ttyAMA0 -P bcm -S 3000000";
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };
  
    
  # !!! Adding a swap file is optional, but recommended if you use RAM-intensive applications that might OOM otherwise. 
  # Size is in MiB, set to whatever you want (though note a larger value will use more disk space).
  swapDevices = [ { device = "/swapfile"; size = 2048; } ];

  hardware.enableRedistributableFirmware = true;
  networking.wireless.enable = false;

  system.stateVersion = "23.11";
}
