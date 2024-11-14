{pkgs, ...}: {
  home.packages = [pkgs.swaynotificationcenter];

  xdg.configFile."swaync/config.json".text = builtins.toJSON (
    builtins.fromJSON (builtins.readFile "${pkgs.swaynotificationcenter}/etc/xdg/swaync/config.json")
    // {
      positionY = "bottom";
    }
  );
}
