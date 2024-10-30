{lib, ...}: {
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
        light_dark = "dark";
        lightness = 0.75;
        color_align = {
          mode = "horizontal";
          custom_colors = [];
          fore_back = null;
        };
        backend = "neofetch";
        args = null;
        distro = null;
        pride_month_shown = [];
        pride_month_disable = false;
      };
    };
    kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      settings = {
        background_opacity = lib.mkForce "0.0";
      };
    };
    nix-index.enable = true;
    nushell = {
      enable = true;
      envFile.source = ../files/nushell/env.nu;
      configFile.source = ../files/nushell/config.nu;
    };
    starship = {
      enable = true;
    };
    zoxide.enable = true;
  };
}
