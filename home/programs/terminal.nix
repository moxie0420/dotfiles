{
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.vivid];
  programs = {
    bottom.enable = true;
    btop = {
      enable = true;
      settings = {
        #color_theme = "TTY";
        theme_background = false;
      };
    };
    carapace.enable = true;
    hyfetch = {
      enable = true;
      settings = {
        preset = "transgender";
        mode = "rgb";
        color_align = {
          mode = "horizontal";
        };
      };
    };
    kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      settings = {
        background_opacity = lib.mkForce "0.0";
      };
    };
    nushell = {
      enable = true;
      envFile.source = ../files/nushell/env.nu;
      configFile.source = ../files/nushell/config.nu;
    };
    starship.enable = true;
    zoxide.enable = true;
  };
}
