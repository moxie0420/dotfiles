{self, ...}: {
  environment.systemPackages = [
    self.packages.x86_64-linux.rosePineSddm
  ];

  services.xserver.displayManager.gdm = {
    enable = true;
  };

  services.displayManager = {
    enable = true;
    sddm = {
      enable = false;
      wayland.enable = true;
    };
  };

  security.pam.services.greetd.enableGnomeKeyring = true;
}
