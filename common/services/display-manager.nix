{
  pkgs,
  self,
  ...
}: {
  environment.systemPackages = [self.packages.${pkgs.system}.rosePineCursor];

  services.displayManager.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
  };
}
