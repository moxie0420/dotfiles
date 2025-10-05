{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.moxie.backlight;
in {
  options.moxie.backlight = {
    enable = mkEnableOption "Enable Backlight support";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      environment.systemPackages = [
        pkgs.brightnessctl
      ];

      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils-full}/bin/chgrp video /sys/class/backlight/%k/brightness"
        ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils-full}/bin/chmod g+w /sys/class/backlight/%k/brightness"
        ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils-full}/bin/chgrp input /sys/class/leds/%k/brightness"
        ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils-full}/bin/chmod g+w /sys/class/leds/%k/brightness"
      '';
    })
  ];
}
