{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    blueberry
  ];

  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        KernelExperimental = true;
      };
    };
  };
}
