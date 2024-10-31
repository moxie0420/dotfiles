{
  inputs,
  pkgs,
  self,
  ...
}: let
  gtkcss = pkgs.writeText "gtkgreet.css" ''
    window {
      background-image: url("file://${self.packages.x86_64-linux.rosePineWallpapers}/share/wallpapers/bay.JPG");
      background-size: cover;
      background-position: center;
    }
  '';
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -s ${gtkcss}; swaymsg exit"

    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';
in {
  environment.systemPackages = [
    self.packages.x86_64-linux.rosePineWallpapers
  ];
  services.greetd = {
    enable = true;
    package = pkgs.greetd.gtkgreet;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --unsupported-gpu --config ${swayConfig}";
      };
    };
  };
  services.displayManager = {
    enable = true;
    sessionPackages = [
      inputs.hyprland.packages.${pkgs.system}.default
    ];
  };
}
