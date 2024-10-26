{
  flake.homeManagerModules = {
    rosePine = {
      config,
      lib,
      pkgs,
      self,
      ...
    }:
      with lib; let
        cfg = config.rose-pine;
      in {
        options.rose-pine = {
          enable = mkEnableOption "enable rose-pine for all detected programs";
          starship.enable = mkEnableOption "enable rose-pine for starship";
          vesktop.enable = mkEnableOption "enable rose-pine for vencord";
        };

        config = {
          xdg.configFile =
            mkIf cfg.vesktop.enable {
              "vesktop/themes/rose-pine.theme.css".source = "${self.packages.x86_64-linux.rosePineVesktop}/rose-pine.theme.css";
              "vesktop/themes/rose-pine-moon.theme.css".source = "${self.packages.x86_64-linux.rosePineVesktop}/rose-pine-moon.theme.css";
            }
            // mkIf cfg.starship.enable {
              "starship.toml".source = "${self.packages.x86_64-linux.rosePineVencord}/rose-pine.toml";
            };
        };
      };
  };
}
