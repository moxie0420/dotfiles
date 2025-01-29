{
  pkgs,
  self,
  ...
}: {
  environment.systemPackages = [self.packages.${pkgs.system}.rose-pine-cursor];

  services.displayManager.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    autoSuspend = false;
  };
}
