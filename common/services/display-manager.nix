{
  pkgs,
  self,
  ...
}: {
  environment.systemPackages = [
    self.packages.${pkgs.system}.rose-pine-cursor
    # (pkgs.sddm-chili-theme.override {
    #   themeConfig = {
    #     ScreenWidth = 1920;
    #     ScreenHeight = 1080;
    #   };
    # })
  ];

  services.displayManager.lemurs = {
    enable = true;
  };

  # services.displayManager.sddm = {
  #   enable = false;
  #   wayland.enable = true;
  #   theme = "chili";
  #   extraPackages = [pkgs.libsForQt5.layer-shell-qt];
  #   settings = {
  #     General = {
  #       HaltCommand = "${pkgs.systemd}/bin/systemctl poweroff";
  #       RebootCommand = "${pkgs.systemd}/bin/systemctl reboot";
  #       DisplayServer = "wayland";
  #       GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
  #     };

  #     Wayland = {
  #       CompositorCommand = lib.mkForce "${hyprland}/bin/Hyprland -c ${config}/share/hypr/sddm/hyprland.conf";
  #     };
  #   };
  # };
}
