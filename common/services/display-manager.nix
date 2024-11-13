{self, ...}: {
  environment.systemPackages = [
    self.packages.x86_64-linux.rosePineSddm
  ];

  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  security.pam.services.greetd.enableGnomeKeyring = true;
}
