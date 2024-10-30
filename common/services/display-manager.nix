{
  inputs,
  pkgs,
  ...
}: let
  gtkcss = builtins.readFile ./gtkgreet.css;
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -s ${gtkcss}; swaymsg exit"

    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';
in {
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
