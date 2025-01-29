{pkgs, ...}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock ";
        before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
        after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on; ${pkgs.brillo}/bin/brillo -I";
      };
      listener = [
        {
          timeout = 120;
          on-timeout = "${pkgs.brillo}/bin/brillo -O; ${pkgs.brillo}/bin/brillo -S 15";
          on-resume = "${pkgs.brillo}/bin/brillo -I";
        }
        {
          timeout = 120;
          on-timeout = "openrgb -d 0 -c 000000";
          on-resume = "openrgb -d 0 -p /home/moxie/.config/OpenRGB/default.orp";
        }
        {
          timeout = 120;
          on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          timeout = 900;
          on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
