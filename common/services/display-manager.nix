{
  pkgs,
  self,
  ...
}: {
  environment.systemPackages = [
    self.packages.${pkgs.system}.rose-pine-cursor
    (pkgs.sddm-chili-theme.override {
      themeConfig = {
        ScreenWidth = 1920;
        ScreenHeight = 1080;
      };
    })
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "chili";
    settings = {
      General = {
        InputMethod = "qtvirtualkeyboard";
      };
    };
  };
}
