{pkgs, ...}: {
  # smooth backlight control
  hardware.brillo.enable = true;
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    package = pkgs.openrgb-with-all-plugins;
  };
}
